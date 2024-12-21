pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: '{your github repo url here}'
            }
        }
        stage('Install Terraform') {
            steps {
                sh '''
                wget https://releases.hashicorp.com/terraform/1.5.6/terraform_1.5.6_linux_amd64.zip
                unzip -o terraform_1.5.6_linux_amd64.zip
                sudo mv terraform /usr/local/bin/
                terraform --version
                '''
            }
        }

To integrate the Service Principal credentials into Jenkins, follow these steps:

Step 1: Log in to Jenkins
Open Jenkins in your web browser.
Log in with your administrator credentials.
Step 2: Add the Credentials
Navigate to Credentials:

From the Jenkins dashboard, go to Manage Jenkins → Manage Credentials.
Select the appropriate scope (e.g., Global or a specific folder).
Add a New Credential:

Click on Add Credentials.
Select Credential Type:

In the Kind dropdown, select Username with password.
Enter the Azure Service Principal Details:

Username: The appId of your Service Principal.
Password: The password (Client Secret) of your Service Principal.
ID: Give it a recognizable ID, like azure_sp.
Save the Credential:

Click OK to save the credentials.
Step 3: Update Your Jenkinsfile
Modify the Jenkinsfile to reference these credentials. Here's an example:

        stage('Azure Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'azure_sp', usernameVariable: 'ARM_CLIENT_ID', passwordVariable: 'ARM_CLIENT_SECRET')]) {
                    sh '''
                    export ARM_CLIENT_ID=$ARM_CLIENT_ID
                    export ARM_CLIENT_SECRET=$ARM_CLIENT_SECRET
                    export ARM_SUBSCRIPTION_ID=911e746f-0030-41d8-839c-c3579ec74ee4
                    export ARM_TENANT_ID=e35b03b3-c8fe-4c25-a5b7-5cc0aa85d11b
                    az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID
                    '''
                }
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                terraform init
                '''
            }
        }
        stage('Terraform Plan') {
            steps {
                sh '''
                terraform plan
                '''
            }
        }
        stage('Terraform Apply') {
            steps {
                sh '''
                terraform apply -auto-approve
                '''
            }
        }
    }
}
