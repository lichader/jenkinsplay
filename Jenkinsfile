pipeline {
  environment {
    registry = "lichader/jenkinsplay"
    registryCredential = 'dockerhub'
  }
  agent any
  stages {
    stage('Building image') {
      steps{
        script {
          docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
        steps{
            script {
                docker.withRegistry('', registryCredential ) {
                    def dockerImage = docker.image(registry + ":$BUILD_NUMBER")
                    dockerImage.push()
                }
            }
        }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}