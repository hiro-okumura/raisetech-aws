# 第 4 回課題

## VPC の作成

![VPC](images/vpc.png)

## EC2 の作成

![EC2](images/ec2.png)

## EC2 のセキュリティグループ

![EC2-SG](images/ec2-sg.png)

## RDS の作成

- 今回 RDS はシングル AZ 構成だが、AWS の用件に沿って最低限 2 つのサブネットを指定して、サブネットグループを作成した

![RDS](images/rds.png)

## RDS のセキュリティグループ

![RDS-SG](images/rds-sg.png)

## EC2 から RDS へ接続

- Tera Term を用いて EC2 のパブリック IP を指定し、.pem を読み込ませて EC2 に接続した。
  ![Tera_Term](images/Tera_Term.png)<br><br>

- MySQL をインストールし、下記画像の通り MySQL を起動した。
  ![MySQLを起動](images/mysql-login.png)

## 感想

- EC2 のウィザードからセキュリティグループを新規作成しようとすると、自分で名前を決められず launch-wizard-01 で作成されてしまった。次回からは先に SG を作成してから EC2 を作成する手順をとりたい。
- EC2 作成時に AZ を指定しても強制的に ap-northeast-1c に作成されるという事態に陥った（1a を指定していた）。調べてみたところ AWS 側の都合でインスタンスの作成に制約がかかるケースがあるとのこと。今回は RDS を同じ AZ に配置して対応した。
