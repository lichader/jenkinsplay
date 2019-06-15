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
                    dockerImage.push("latest")
                }
            }
        }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
    stage('Create new Tag'){
      steps {
        sh 'git config --global user.email jenkins-build@lichader.com'
        sh 'git config --global user.name jenkins'
        sh 'git tag -a "build-$BUILD_NUMBER" -m "Tag build $BUILD_NUMBER"'
        sshagent (credentials: ['github']) {
          sh 'git push origin build-$BUILD_NUMBER'
        }
      }

    }
  }
}