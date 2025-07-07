pipeline {
  agent any

  environment {
    AWS_REGION = 'us-east-1'
    AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
  }

  stages {
    stage('Checkout Code') {
      steps {
        git branch: 'main', url: 'https://github.com/your-org/infra-cicd-template.git'
      }
    }

    stage('Terraform Init') {
      steps {
        sh '''
          terraform init
        '''
      }
    }

    stage('Terraform Validate') {
      steps {
        sh 'terraform validate'
      }
    }

    stage('Terraform Plan') {
      steps {
        sh 'terraform plan -input=false'
      }
    }

    stage('Terraform Apply') {
      steps {
        sh 'terraform apply -auto-approve -input=false'
      }
    }
  }

  post {
    always {
      echo 'Pipeline execution completed.'
    }
  }
}
