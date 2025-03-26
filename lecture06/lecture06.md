# 第 6 回課題の提出

## CloudTrail を使ったロギング

- AWS ユーザーの操作をロギングするサービス。
- Json 形式で詳細なログが保存される。

![CloudTrail](images/CloudTrail.png)

### 保存されるログの一例

**操作したユーザーに関する情報**

![ユーザー名](images/Cloudtrail-UserName.png)

**イベントに関する情報**

![イベント名](images/CloudTrail-StartInstances.png)

**インスタンスのステータスがどうなったか**

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

[第 5 回までに作成したリソースを参考にした見積り](https://calculator.aws/#/estimate?id=5661dd7874eeff3bc0213b9e6f15dac359c68a3c)

## アカウントの利用料の確認

![アカウントの請求情報](images/Billing.png)

## 感想

- メトリクス・しきい値・アクションを設定することで CloudWatch のアラーム内容を詳細にコントロールできることを学びました。
- CloudTrail では、IAM グループを使った複数人の開発現場においてユーザーの操作情報を確認できるため実務での重要性を感じました。
