pipeline {
  agent any

  parameters {
    string(name: 'ENV_DIR', defaultValue: 'envs/dev', description: 'Environment directory (e.g., envs/dev)')
    string(name: 'TF_VARS_FILE', defaultValue: 'terraform.tfvars', description: 'Variable file name')
  }

  environment {
    AWS_DEFAULT_REGION = 'us-east-1'
    TF_IN_AUTOMATION = 'true'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Terraform Init') {
      steps {
        dir("${params.ENV_DIR}") {
          sh 'terraform init -upgrade'
        }
      }
    }

    stage('Terraform Validate') {
      steps {
        dir("${params.ENV_DIR}") {
          sh 'terraform validate'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        dir("${params.ENV_DIR}") {
          sh "terraform plan -var-file=${params.TF_VARS_FILE}"
        }
      }
    }

    stage('Manual Approval') {
      steps {
        input message: "Approve Apply to ${params.ENV_DIR}?"
      }
    }

    stage('Terraform Apply') {
      steps {
        dir("${params.ENV_DIR}") {
          sh "terraform apply -var-file=${params.TF_VARS_FILE} -auto-approve"
        }
      }
    }
  }

  post {
    success {
      echo "✅ Terraform Applied Successfully!"
    }
    failure {
      echo "❌ Failed to apply Terraform"
    }
  }
}
