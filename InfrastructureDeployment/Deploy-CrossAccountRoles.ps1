[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]
    $BucketName,

    [Parameter(Mandatory=$true)]
    [string]
    $BuildAccountNo,

    [Parameter(Mandatory=$true)]
    [string]
    $ArtefactKMSKeyArn,

    [Parameter()]
    [string]
    $Region = "ap-southeast-2",

    [Parameter()]
    [string]
    $AwsProfile = $env:AWS_PROFILE
)

$cfnPath = Join-Path $PSScriptRoot "CrossAccountRoles.yml"

write-verbose "deploying cloudformation template $cfnPath"
aws cloudformation deploy `
    --template-file $cfnPath `
    --s3-bucket $BucketName `
    --s3-prefix "cross-roles" `
    --stack-name "infrastructure-pipeline-roles" `
    --capabilities CAPABILITY_NAMED_IAM `
    --region $Region `
    --no-fail-on-empty-changeset `
    --parameter-overrides BuildAccountNo=$BuildAccountNo ArtefactKMSKeyArn=$ArtefactKMSKeyArn `
    --profile $AwsProfile