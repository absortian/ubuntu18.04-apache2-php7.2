// Jenkinsfile that builds the docker image and pushes it to the registry
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t absortian/absortian:ubuntu18.04-apache2-php7.2 .'
            }
        }
        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker login -u $USERNAME -p $PASSWORD'
                    sh 'docker tag myimage $USERNAME/myimage'
                    sh 'docker push $USERNAME/myimage'
                }
            }
        }
    }
}