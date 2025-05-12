# 第 13 回課題

**_CircleCI に CloudFormation・Ansible・Serverspec を組み込んで Rails アプリケーションを自動デプロイする_**

## 概要

1. 実施内容
2. 結論：CircleCI 上の実行結果
3. 手順：Ansible の手動構築
4. 学んだ事
5. 感想

## 実施内容: CircleCI に以下の 4 つのジョブを実装する

1. `cfn-lint:` CloudFormation の構文をチェックする
2. `execute-cfn:` CloudFormation を実行して AWS 環境を構築する
3. `execute-ansible:` Ansible でインフラの構成管理とデプロイ自動化する
4. `execute-serverspec:` Serverspec を実行して構築したサーバーの構成をテストする

### 前提

#### 課題の実施に使用したリポジトリ：[Lecture13-Ansible](https://github.com/hiro-okumura/Lecture13-Ansible)

#### CircleCI のコンソールで以下の項目を設定する

- 環境変数

  - AWS_ACCESS_KEY_ID
  - AWS_DEFAULT_REGION
  - AWS_SECRET_ACCESS_KEY

![環境変数](/lecture13/Environment_Variables.png)

- SSH KEY

![SSH_KEY](/lecture13/SSH_KEY.png)

## 結論：CircleCI における実行結果

### cfn-lint の実行結果

![cfn-lint](/lecture13/cfn-lint.png)

### execute-cfn の実行結果

![execute-cfn](/lecture13/execute-cfn.png)

### execute-ansible の実行結果

![execute-ansible](/lecture13/execute-ansible.png)

### execute-serverspec の実行結果

![execute-serverspec](/lecture13/execute-serverspec.png)
![Serverspecの詳細結果](/lecture13/bundle_exec_rake_spec.png)

### アプリケーションの動作確認

#### ALB の DNS を 利用してブラウザからアクセスに成功

![アプリケーション動作確認](/lecture13/ALB_DNSでアプリにアクセス.png)

#### S3 に画像が保存されている事を確認

![S3 画像の保存先](/lecture13/S3に保存.png)

## 手順: Ansible の手動構築の一部

- CircleCI 上でいきなり自動化するのではなく、手動構築から進めて徐々にタスクを追加していくことにした。
- ターゲットノードとは別に、コントロールノード用の EC2 インスタンスを別途用意して`ssh-agent`で接続。
- プレイブックの実行にはタグを使いながら動作確認をした。`ansible-playbook -i inventory.ini playbook.yml  -t "yum"`。
- 本課題は CircleCI 上での自動デプロイのため、手動構築でアプリケーションまですべてを実装することはしない事とした。あくまで、手動構築を経ることで実装内容のイメージを掴むための目的とした。

![tree](/lecture13/ansible-tree.png)
![Playbook.yml](/lecture13/ansible-playbook.png)
![roles/rbenv](/lecture13/playbook_rbenv.png)
![roles/nodejs](/lecture13/playbook_nodejs.png)
![roles/web_server](/lecture13/playbook-web_server.png)
![バージョン情報](/lecture13/version.png)

## 学んだ事

### Ansible の基本については Udemy の講座で学習

- [AWS で学ぶ！ Ansible による Infrastructure as Code 入門](https://www.udemy.com/course/aws-ansibleinfrastructure-as-code/?couponCode=CP130525JP)

![Udemyの講座](/lecture13/udemy_ansible_course.png)

- 学習内容
  - Ansible の基本（inventory, Playbook, module, role など）
  - 様々な module のハンズオン（command, service, file, copy, script, debug, lineinfile, shell, get_url, template, user, setup, reboot, yum ）
  - vars 変数のプレイブック内定義と外部ファイル定義や register 変数
  - ロール分割
  - `ssh-agent` を使って EC2 に接続
  - ElasticIP 割り当て

### Ansible について勉強になったところ

- `execute-ansible:`ジョブ内で ansible.cfg を明示的に指定する。（デフォルトのままでは ansible.cfg が読み込まれず SSH 接続時にエラーが発生していた）

```
  # .circleCI/config.yml
  execute-ansible:
    environment:
      ANSIBLE_CONFIG: ansible/ansible.cfg
```

- RDS のエンドポイントなどの AWS リソース情報を取得する方法

  1. CloudFormation テンプレートの Outputs セクションに取得したい情報を記述する。

  ```
  # cloudformation/database.yml
    Outputs:
      RDSEndpoint:
        Description: Endpoint of RDS instance
        Value: !GetAtt MyRDS.Endpoint.Address
  ```

  2. CircleCI に、取得したい情報を `$BASH_ENV` に格納する処理を追加する。

  ```
  # .circleci.config.yml
  command: |
    AWS_RDS_ENDPOINT=$(aws cloudformation describe-stacks --stack-name lecture13-database-stack \
        --query "Stacks[0].Outputs[?OutputKey=='RDSEndpoint'].OutputValue" --output text)
    echo "export AWS_RDS_ENDPOINT=${AWS_RDS_ENDPOINT}" >> $BASH_ENV
  ```

  3. `lookup` を使って取得した環境変数を呼び出す。今回は jinja2 テンプレートに埋め込む。`.txt`などのファイルの中身を取得する形でも使用できる。

  ```
  # raisetech-live8-sample-app/config/database.yml
  host: {{ lookup('env', 'AWS_RDS_ENDPOINT') }}
  ```

## 感想

- 課題の最初は何から手を付けるべきか分からず困惑していました。まずは第 5 回の内容を振り返り、もう 1 度ターミナルから手動でパッケージを入れていき動作確認をしました。その後も Ansible を手動構築で確認することで徐々に全体像が見えてくるようになりました。段階的に開発を進めていく事の重要性を学びました。
- Ansible の SSH 接続まわりで苦戦していましたが、デバッグを繰り返していくうちに ansible.cfg が正しく読み込まれていなかったことが原因だと判明しました。自力で原因を突き止められたことで、RaiseTech で課題の提出を始めたばかりの頃と比べて自分の成長を実感できました。
