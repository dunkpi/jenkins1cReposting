@Library("shared-libraries")
import libs.ProjectHelpers
import libs.Utils

def utils = new Utils()
def projectHelpers = new ProjectHelpers()
def repost8Tasks = [:]

pipeline {
    parameters {
        string(defaultValue: "${env.jenkinsAgent}", description: 'Нода дженкинса, на которой запускать пайплайн. По умолчанию master', name: 'jenkinsAgent')
        string(defaultValue: "${env.platform1c}", description: 'Версия платформы 1с, например 8.3.14.1694. По умолчанию будет использована последня версия среди установленных', name: 'platform1c')
        string(defaultValue: "${env.server1c}", description: 'Имя сервера 1с, по умолчанию localhost', name: 'server1c')
        string(defaultValue: "${env.infobases}", description: 'Список баз для обновления через запятую. Например c83_ack,c83_ato', name: 'infobases')
        string(defaultValue: "${env.user}", description: 'Имя администратора базы 1с Должен быть одинаковым для всех баз', name: 'user')
        string(defaultValue: "${env.passw}", description: 'Пароль администратора базы 1C. Должен быть одинаковым для всех баз', name: 'passw')
        string(defaultValue: "${env.startDate}", description: 'Дата начала периода', name: 'startDate')
        string(defaultValue: "${env.endDate}", description: 'Дата окончания периода', name: 'endDate')
        string(defaultValue: "${env.backupDir}", description: 'Путь для сохранения логов 1c', name: 'backupDir')
    }
    agent {
        label "${(env.jenkinsAgent == null || env.jenkinsAgent == 'null') ? "master" : env.jenkinsAgent}"
    }
    options {
        timeout(time: 8, unit: 'HOURS') 
        buildDiscarder(logRotator(numToKeepStr:'10'))
    }
    stages {
        stage("Подготовка") {
            steps {
                timestamps {
                    script {
                        infobasesList = utils.lineToArray(infobases.toLowerCase())
                        platform1c = "C:\\Program Files (x86)\\1cv8\\" + (platform1c.isEmpty() ? "common\\1cestart.exe" : (platform1c + "\\bin\\1cv8.exe"))
                        server1c = server1c.isEmpty() ? 'localhost' : server1c

                        println("startDate: " + startDate)
                        println("endDate: " + endDate)
                    }
                }
            }
        }
        stage("Запуск") {
            steps {
                timestamps {
                    script {
                        for (i = 0;  i < infobasesList.size(); i++) {
                            infobase = infobasesList[i]
                            // 1. Запускаем обработку перепроведения 1С 8
                            repost8Tasks["repost8Tasks_${infobase}"] = repost8Tasks(server1c, port1c, infobase, user, passw, startDate, endDate, backupDir)
                        }
                        // parallel repost8Tasks
                    }
                }
            }
        }
    }
   post {
        always {
            emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
                recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"
        }
    }
}

def repost8Task(server1c, port1c, infobase, user, passw, startDate, endDate, backupDir) {
    return {
        stage("Перепроведение 1С 8 ${infobase}") {
            timestamps {
                def projectHelpers = new ProjectHelpers()
                projectHelpers.repost8Task(server1c, port1c, infobase, user, passw, startDate, endDate, backupDir)
            }
        }
    }
}