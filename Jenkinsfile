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
                dir('example-voting-app-kubernetes') {
                    sh '''
                    aws eks --region "us-east-1" update-kubeconfig --name test-eks-72XMEz3q
                    kubectl apply -f voting-app-deploy.yaml
                    kubectl apply -f voting-app-service.yaml
                    kubectl apply -f result-app-deploy.yaml
                    kubectl apply -f result-app-service.yaml
                    kubectl apply -f worker-app.deploy.yaml                    
                    kubectl apply -f postgres-deploy.yaml
                    kubectl apply -f postgres-service.yaml
                    kubectl apply -f redis-deploy.yaml
                    kubectl apply -f redis-service.yaml
                    '''
                }
            }
        }
    }
}
