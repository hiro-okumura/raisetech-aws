# 第 6 回課題の提出

## CloudTrail を使ったロギング

- ユーザーや AWS で主体となるサービスの操作をロギングするサービス。
- Json 形式で詳細なログが保存される。

![CloudTrail](images/CloudTrail.png)

### 保存されるログの一例

**操作したユーザーに関する情報**

- 操作したユーザー： `"RaiseTech-User"`

![ユーザー名](images/Cloudtrail-UserName.png)

**イベントに関する情報**

- イベント名：`"StartInstances"`
- イベントが発生した時間やリージョン、ソース元の IP アドレスなど

![イベント名](images/CloudTrail-StartInstances.png)

**インスタンスのステータスがどうなったか**

- インスタンスの状態：`"Pending"`（起動中）

![インスタンスのステータス](images/CloudTrail-CurrentState.png)

## CloudWatch アラーム

- UnhealtyHostCount を記録する CloudWatch アラームを作成する。
- AmazonSNS と連携してメール通知する。
- アラーム状態と OK 状態を確認する。

![CloudWatchアラームを作成](images/CloudWatch-Alarm.png)

**UnhealtyHostCount を メール で受け取る**

![SNS通知](images/SNS-Notification.png)

**OK アクションの設定と確認**

![OKアクションの設定](images/CloudWatch-OK-Action.png)

![OK状態](images/CloudWatch-Status-OK.png)

![OKアクションのSNS通知](images/CloudWatch-OK-SNS.png)

## AWS 利用料の見積り

[第 5 回までに作成したリソースを参考にした見積り](https://calculator.aws/#/estimate?id=b8435e5195ba58dc9ad03129a833fabb6ad786bd)

## アカウントの利用料の確認

- EC2 インスタンス起動状態のパブリック IP アドレスに対して課金されている。
- AWS サービスを利用する際には、まず無料利用枠を確認するようにしているため、それ以外のサービスは無料利用枠の範囲に収まっている。

![アカウントの請求情報](images/Billing.png)

![パブリックIPの請求情報](images/Binlling-Public-IP.png)

![パブリックIPの料金](images/Public-IP.png)

## 感想

- メトリクス・しきい値・アクションを設定することで CloudWatch のアラーム内容を詳細にコントロールできることを学びました。
- CloudTrail では、IAM グループを使った複数人の開発現場においてユーザーの操作情報を確認できるため実務での重要性を感じました。
