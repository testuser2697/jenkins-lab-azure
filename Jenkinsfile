pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: ''
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
        stage('Set Azure Environment Variables') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'azure_sp', usernameVariable: 'ARM_CLIENT_ID', passwordVariable: 'ARM_CLIENT_SECRET')]) {
                    sh '''
                    export ARM_CLIENT_ID=$ARM_CLIENT_ID
                    export ARM_CLIENT_SECRET=$ARM_CLIENT_SECRET
                    export ARM_SUBSCRIPTION_ID=911e746f-0030-41d8-839c-c3579ec74ee4
                    export ARM_TENANT_ID=e35b03b3-c8fe-4c25-a5b7-5cc0aa85d11b
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
