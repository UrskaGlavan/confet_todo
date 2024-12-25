pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('SonarQube Analysis') {
            environment {
                SonarQube
                SONARQUBE_SERVER = 'SonarQube'
            }
            steps {
                // Zagon SonarQube skenerja
                sh """
                sonar-scanner \
                -Dsonar.projectKey=confet_todo \
                -Dsonar.sources=. \
                -Dsonar.host.url=${SONARQUBE_SERVER} \
                -Dsonar.login=<SONARQUBE_TOKEN>
                """
            }
        }
    }
}
