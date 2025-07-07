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

  options {
    timestamps()
    // ansiColor('xterm') — Uncomment if plugin is installed
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Terraform Init') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-access-key-id'  // ✅ Replace with correct AWS credential ID
        ]]) {
          dir("${params.ENV_DIR}") {
            sh 'terraform init -upgrade'
          }
        }
      }
    }

    stage('Terraform Validate') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-access-key-id'
        ]]) {
          dir("${params.ENV_DIR}") {
            sh 'terraform validate'
          }
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-access-key-id'
        ]]) {
          dir("${params.ENV_DIR}") {
            sh "terraform plan -var-file=${params.TF_VARS_FILE}"
          }
        }
      }
    }

    stage('Manual Approval - Apply') {
      steps {
        input message: "✅ Approve APPLY to ${params.ENV_DIR}?"
      }
    }

    stage('Terraform Apply') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-access-key-id'
        ]]) {
          dir("${params.ENV_DIR}") {
            sh "terraform apply -var-file=${params.TF_VARS_FILE} -auto-approve"
          }
        }
      }
    }

    stage('Manual Approval - Destroy') {
      steps {
        input message: "⚠️ Apply completed. Do you want to DESTROY the infrastructure in ${params.ENV_DIR}?"
      }
    }

    stage('Terraform Destroy') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-access-key-id'
        ]]) {
          dir("${params.ENV_DIR}") {
            sh "terraform destroy -var-file=${params.TF_VARS_FILE} -auto-approve"
          }
        }
      }
    }
  }

  post {
    success {
      echo "✅ Terraform Apply and Destroy completed successfully!"
    }
    failure {
      echo "❌ Terraform operation failed."
    }
  }
}
