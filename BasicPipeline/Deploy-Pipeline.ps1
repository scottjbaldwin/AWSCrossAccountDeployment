[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]
    $BucketName,

    [Parameter(Mandatory=$true)]
    [string]
    $DevAccountNo,

    [Parameter(Mandatory=$true)]
    [string]
    $ProdAccountNo,

    [Parameter(Mandatory=$true)]
    [string]
    $CodeStarConnectionArn,

    [Parameter()]
    [string]
    $Region = "ap-southeast-2",

    [Parameter()]
    [string]
    $AwsProfile = $env:aws_profile
)

$cfnPath = Join-Path $PSScriptRoot "pipeline.yml"

write-verbose "deploying cloudformation template $cfnPath"
aws cloudformation deploy `
    --template-file $cfnPath `
    --s3-bucket $BucketName `
    --s3-prefix "cross-account" `
    --stack-name "basic-pipeline" `
    --capabilities CAPABILITY_NAMED_IAM `
    --region $Region `
    --no-fail-on-empty-changeset `
    --parameter-overrides DevAccountNo=$DevAccountNo ProdAccountNo=$ProdAccountNo  CodeStarConnectionArn=$CodeStarConnectionArn `
    --profile $AwsProfile