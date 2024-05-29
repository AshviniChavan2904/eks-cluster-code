pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage('Checkout SCM') {
            steps {
                script {
                    checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/AshviniChavan2904/eks-cluster-code.git']])
                }
            }
        }
        stage('Terraform Initialization') {
            steps {
                dir('eks-terraform') {
                    sh 'terraform init -upgrade'
                }
            }
        }
        stage('Terraform Formatting') {
            steps {
                dir('eks-terraform') {
                    sh 'terraform fmt'                    
                }
            }   
        }
        stage('Terraform Validation') {
            steps {
                dir('eks-terraform') {
                    sh 'terraform validate'                    
                }                
            }
        }
        stage('Terraform Plan') {
            steps {
                dir('eks-terraform') {
                    sh 'terraform plan'
                }                
            }
        }
        stage('Terraform Resource Creation') {
            steps {
                dir('eks-terraform') {
                    input(message: "Do you want to apply the changes?", ok: "Proceed")                    
                    sh 'terraform $action --auto-approve'                    
                }                
            }
        }
        stage('Deploy K8s Voting App') {
            steps {
                dir('example-voting-app-kubernetes-v2') {
                sh '''
                aws eks --region "us-east-1" update-kubeconfig --name test-eks-72XMEz3q
                kubectl create -f voting-app-deployment.yml
                kubectl create -f voting-app-service.yml
                kubectl create -f result-app-deployment.yml 
                kubectl create -f result-app-service.yml
                kubectl create -f worker-app-deployment.yml
                kubectl create -f postgres-deployment.yml
                kubectl create -f postgres-service.yml
                kubectl create -f redis-deployment.yml
                kubectl create -f redis-service.yml
                '''
                }
            }
        }
    }
}
