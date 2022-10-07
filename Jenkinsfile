// Jenkinsfile that builds the docker image and pushes it to the registry

def notifyEndOfBuild() {
    def buildStatus = currentBuild.currentResult
    def colorName = 'RED'
    def colorCode = '#FF0000'
    if (buildStatus == 'SUCCESS') {
        colorName = 'GREEN'
        colorCode = '#00FF00'
    }
    // Send to default recipients
    emailext (
        subject: "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
        body: """<p>RESULT: ${buildStatus}</p>
                 <p>Check console output at <a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a></p>""",
        recipientProviders: [[$class: 'DevelopersRecipientProvider']],
        to: '$DEFAULT_RECIPIENTS'
    )
}

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
                    sh 'docker push $USERNAME/absortian:ubuntu18.04-apache2-php7.2'
                }
            }
        }
        stage('Notify') {
            steps {
                notifyEndOfBuild()
            }
        }
    }
}