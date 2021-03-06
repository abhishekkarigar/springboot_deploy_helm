podTemplate(nodeSelector: 'kubernetes.io/hostname=minikube',label: 'mypod', containers: [
    containerTemplate(name: 'git', image: 'alpine/git', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'maven', image: 'maven:3.3.9-jdk-8-alpine', command: 'cat', ttyEnabled: true),
    containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true)
  ],
  volumes: [
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
    hostPathVolume(mountPath: '/home/jenkins/agent', hostPath: '//c/Users/karigar/Music/mounts'),
    hostPathVolume(mountPath: '/root/.m2', hostPath: '//c/Users/karigar/.m2')
  ]
  ) {
    node('mypod') {
        stage('Check running containers') {
            container('docker') {
                // example to show you can run docker commands when you mount the socket
                sh 'hostname'
                sh 'hostname -i'
                sh 'docker ps'
            }
        }
        
        stage('Clone repository') {
            container('git') {
                dir('springboot_deploy_helm'){
                    deleteDir()
                }
                sh 'whoami'
                sh 'hostname -i'
                sh 'git clone https://github.com/abhishekkarigar/springboot_deploy_helm.git'
            }
        }

        stage('Maven Build') {
            container('maven') {
                dir('springboot_deploy_helm/') {
                    sh 'hostname'
                    sh 'hostname -i'
                    sh 'mvn clean install'
                }
            }
        }
    }
}