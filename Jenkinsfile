pipeline{

    environment {
        dockerimagename = "steveric/myimage2"
        dockerImage = ""
    }
    
    agent any

    stages {
        stage('git clone') {
            steps {
                git 'https://github.com/Steveric1/JENKINS-CI-CD.git'
            }
        }
        stage('Build image') {
            steps {
                script {
                    dockerImage = docker.build dockerimagename
                }
            }
        }
        stage('pushing image') {
            environment {
                registryCredential = 'dockerhub'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                        dockerImage.push("latest")
                    }
                }
            }
        }
        stage('Deploying Kubernetes') {
            steps {
                script {
                    kubernetesDeploy(configs: 'complete.yml', kubeConfigId: 'kubernetes')
                }
            }
        }
    }
}
