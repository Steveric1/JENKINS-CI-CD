pipeline {
    agent any
    environment {
        devs = "seniorDevs"
    }

    stages {
        stage('Deploying Kubernetes') {
            steps {
                sshagent(['Admin1_SSH_Private_Key']) {
                    sh "scp -o strictHostKeyChecking=no complete.yml ec2-user@54.160.191.176: /home/ec2-user"
                    script {
                        try {
                            sh "ssh ec2-user@54.160.191.176 kubeclt apply -f complete.yml"
                        } catch(error) {
                            sh "sh ec2-user@54.160.191.176 kubectl create -f complete.yml"
                        }
                    }
                }
            }
        }
        stage('git clone socks app') {
            steps {
                git branch: 'master', url: 'https://github.com/Steveric1/microservices-demo.git'
            }
        }
        stage('Deploy socks web applications') {
            steps {
                sshagent(['Admin1_SSH_Private_Key']) {
                    sh 'cd $WORKSPACE/deploy/kubernetes'
                    sh "scp -o strictHostKeyChecking=no complete-demo.yaml ec2-user@54.160.191.176: /home/ec2-user"
                    script {
                        try {
                            sh "ssh ec2-user@54.160.191.176 kubectl apply -f complete-demo.yaml"
                        } catch(error) {
                            sh "ssh ec2-user@54.160.191.176 kubectl create -f complete-demo.yaml"
                        }
                    }
                }
            }
        }
    }
}




