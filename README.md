# GitHub Actions - AWS Lambda deploy template

This is a template repository for quickly creating an Actions-deployed AWS Lambda function.

Every push to the master branch will be automatically deployed to AWS.

## Setup

Go to [AWS Lambda console](https://console.aws.amazon.com/lambda/home) and create a new function. Select runtime as Python 3.8 and configure triggers as needed. If you need a more detailed guide, check out [my blog](https://ibug.io/p/41) for configuring API Gateway with Lambda.

Go to [AWS IAM console](https://console.aws.amazon.com/iam/home) and create a new policy. Here's an example JSON that you can copy:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "iam:ListRoles",
        "lambda:UpdateFunctionCode",
        "lambda:CreateFunction"
      ],
      "Resource": "*"
    }
  ]
}
```

Also on the IAM console, create a new user and attach the policy from the above step. Create a pair of access keys for the new user.

[Create a new repo](https://github.com/iBug/actions-lambda-python/generate) from this template. Go to the Settings tab of your new repository and add the following secrets:

| Name | Description |
| :--: | :---------: |
| `AWS_ACCESS_KEY_ID` | AWS access key ID |
| `AWS_SECRET_ACCESS_KEY` | AWS secret access key |
| `AWS_FUNCTION_NAME` | Name of your Lambda function |

Now write your code and push. GitHub Actions should automatically deploy your code to your specified function.

Be aware that non-secret environment variables configured for your Lambda function will be printed out. You can edit [`Makefile`](Makefile) as needed.

## License

[The MIT License](LICENSE)
