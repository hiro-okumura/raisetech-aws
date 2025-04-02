# 第 10 回講義の課題

## 課題内容

- これまでに構築した AWS リソースを CloudFormation で構築する。

## 使用したテンプレート

- [lecture10-network.yml](templates/lecture10-network.yml)（VPC / サブネット / IGW / ルートテーブル）
- [lecture10-security.yml](templates/lecture10-security.yml)（セキュリティグループ / IAM ロール / インスタンスプロファイル ）
- [lecture10-application.yml](templates/lecture10-application.yml)（EC2 / ALB 関連 / RDS / S3）
- [lecture10-database.yml](templates/lecture10-database.yml)（RDS / サブネットグループ / シークレット）

### スタック

![スタック](images/Cfn-Stack.png)

## テンプレートによって作成されたリソース

### VPC

![VPC](images/VPC.png)

### インターネットゲートウェイ

![IGW](images/IGW.png)

### デフォルトのパブリックルートテーブル設定

![DefaultPublicRoute](images/PublicRouteTable.png)

### EC2

![](images/EC2.png)

### EC2 のセキュリティグループ

![EC2](images/EC2-SG.png)

### RDS

![RDS](images/RDS.png)

### RDS のセキュリティグループ

![REDS-SG](images/RDS-SG-Inbound.png)

### DB のサブネットグループ

![DBサブネットグループ](images/DB-Subnet-Group.png)

### ALB

![ALB](images/ALB.png)

### ALB のセキュリティグループ

![ALB-SG](images/ALB-SG.png)

### ALB のターゲットグループ

![ALB-Target-Group](images/ALB-Target-Group.png)

### S3 バケット

![S3](images/S3.png)

### S3 アクセスを許可するための IAM ロール

![S3-IAMロール](images/IAM-Role.png)

## 作成したリソースに接続する

![EC2とMySQLにログイン](images/mysql-login.png)

## 感想

- ロールバックされる仕組みのおかげで、何度もトライアンドエラーを繰り返すことが出来て、非常に学習が捗る良いシステムでした。
- `Outputs` でエクスポートした値を、別のスタックの組み込み関数 Fn::Sub の中で利用する手段がわからず困っていましたが、AWS 公式のドキュメントを参考にして解決することができました。ChatGPT を使っても解決策が返ってこなかったので勉強になりました。
- 第 6 回で学んだ AWS Secret Manger を使用しました。シークレットに値が保存されるので、別途パスワードをメモする必要もなく便利でした。
