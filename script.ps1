# Azure DevOps REST API endpoint for pull requests
$apiUrl = "https://dev.azure.com/Demo-org-2024/Dotnet-project/_apis/pullrequests"
 
# Azure DevOps organization and project information
$organization = "Demo-org-2024"
$project = "Dotnet-project"
 
# Azure DevOps personal access token with necessary permissions
$token = "dubrudx57e5ilh7rojvnjaq5mzzs65uif6vkk474cyjt4nyist3a"
 
# Azure DevOps username for whom you want to fetch assigned pull requests
$assignedUser = "sendevenkat533@gmail.com"
 
# Construct the authorization header

$B64Pat = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes(":$token"))
$headers = @{ Authorization = "Basic $B64Pat" }
                                 
 
# Fetch pull requests from Azure DevOps REST API
$response = Invoke-RestMethod -Uri $apiUrl -Headers $headers -Method Get -ContentType "application/json"
 
# Filter pull requests assigned to the specified user
$assignedPullRequests = $response.value | Where-Object { $_.reviewers -ne $null -and $_.reviewers.user.uniqueName -contains $assignedUser }
# Output information about assigned pull requests
foreach ($pullRequest in $assignedPullRequests) {
    Write-Output "Pull Request #$($pullRequest.pullRequestId): $($pullRequest.title)"
    Write-Output "  URL: $($pullRequest.url)"
    Write-Output "  Created by: $($pullRequest.createdBy.displayName)"
    Write-Output "  Assignee: $($pullRequest.reviewers.user.displayName -join ', ')"
    Write-Output "  Status: $($pullRequest.status)"
    Write-Output "  Created at: $($pullRequest.creationDate)"

}