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
        stage('Azure Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'azure_sp', usernameVariable: 'ARM_CLIENT_ID', passwordVariable: 'ARM_CLIENT_SECRET')]) {
                    sh '''
                    export ARM_CLIENT_ID=$ARM_CLIENT_ID
                    export ARM_CLIENT_SECRET=$ARM_CLIENT_SECRET
                    export ARM_SUBSCRIPTION_ID=<your-subscription-id>
                    export ARM_TENANT_ID=<your-tenant-id>
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
