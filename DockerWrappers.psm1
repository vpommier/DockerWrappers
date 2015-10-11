function ToLinuxPath([string]$str) {
    $a = $str.Replace('\','/').Replace(':','').Replace(' ', '\ ').ToCharArray()
    $a[0] = $a[0].ToString().ToLower()
    return ('/' + ($a -join '') + '/')
}

function StartX11Server {
    if(!(Get-Process -Name vcxsrv -ErrorAction SilentlyContinue)) {
        Start-Process "${env:APPDATA}\Microsoft\Windows\Start Menu\Programs\VcXsrv\VcXsrv.lnk"
    }
}

function GetDisplayIpAddr {
    [string]$ip = ((docker-machine.exe ip $Env:DOCKER_MACHINE_NAME) -replace "\d+$", "1")
    return $ip
}

function Start-DockerVM {
    param(
        [parameter(Mandatory=$true)]
        [string]$name
    )
    if((docker-machine.exe ls -q) -match $name) {
        docker-machine.exe start $name
    } else {
        docker-machine.exe create -d virtualbox $name
    }
    docker-machine.exe env --shell powershell $name | Invoke-Expression
}

function Destroy-DockerVM {
    param(
        [parameter(Mandatory=$true)]
        [string]$name
    )
    docker-machine.exe stop $name
    docker-machine.exe rm $name
}

function Start-IdeAws {
    if ($env:DOCKER_MACHINE_NAME -eq $null) {
        Start-DockerVM -name dockerhost-vm
    }

    [string]$name="ideaws"
    [string]$awsCredentialsVolume = [string]::Format(
        "/{0}{1}/.aws/:/root/.aws/:ro",
        $env:SystemDrive.Replace(':','').ToLower(),
        $env:HOMEPATH.Replace('\','/')
    )
    [string]$displayAddr = [string]::Format(
        "DISPLAY={0}:0",
        (GetDisplayIpAddr)
    )
    StartX11Server
    if (docker ps -a --filter="name=${name}" | Select-String -Pattern $name) {
        docker start $name
    } else {
        docker run -d `
            -h $name `
            --name $name `
            -e $displayAddr `
            -v $awsCredentialsVolume `
            vpommier/ide_aws:latest xterm
    }
}

function Start-IdeTerraform {
    if ($env:DOCKER_MACHINE_NAME -eq $null) {
        Start-DockerVM -name dockerhost-vm
    }

    [string]$name="ideterraform"
    [string]$displayAddr = [string]::Format(
        "DISPLAY={0}:0",
        (GetDisplayIpAddr)
    )
    StartX11Server
    if (docker ps -a --filter="name=${name}" | Select-String -Pattern $name) {
        docker start $name
    } else {
        docker run -d `
            -h $name `
            --name $name `
            -e $displayAddr `
            vpommier/ide_terraform:latest xterm
    }
}

function Start-AwsCli {
    if ($env:DOCKER_MACHINE_NAME -eq $null) {
        Start-DockerVM -name dockerhost-vm
    }

    [string]$workDir = "/aws/"
    [string]$awsCredentialsVolume = [string]::Format(
        "/{0}{1}/.aws/:/root/.aws/:ro",
        $env:SystemDrive.Replace(':','').ToLower(),
        $env:HOMEPATH.Replace('\','/')
    )
    [string]$workDirVolume = [string]::Format(
        "{0}:{1}:rw",
        (ToLinuxPath -str $PWD.Path),
        $workDir
    )
    docker run -it --rm `
        -w $workDir `
        -v $awsCredentialsVolume `
        -v $workDirVolume `
        vpommier/ide_aws:latest aws $args
}

function docker-compose {
    if ($env:DOCKER_MACHINE_NAME -eq $null) {
        Start-DockerVM -name dockerhost-vm
    }
    
    [string]$name = "docker-compose"
    [string]$workDir = "/workdir/"
    [string]$workDirVolume = [string]::Format(
        "{0}:{1}:ro",
        (ToLinuxPath -str $PWD.Path),
        $workDir
    )
    [string]$dockerSockVolume = "/var/run/docker.sock:/var/run/docker.sock"
    [string]$entrypoint = "/usr/bin/docker-compose"

    docker run -it --rm `
        --name $name `
        -h $name `
        -w $workDir `
        -v $dockerSockVolume `
        -v $workDirVolume `
        --entrypoint $entrypoint `
        brainly/compose-in-docker $args
}

<#function Start-SshAgent {
    docker run -d `
        --name ssh-agent `
        vpommier/ssh-agent:latest ssh-agent -a /sshagent/sshagent.sock -d
}

function Start-SshAdd {
    [string]$dotSshVolume = [string]::Format(
        "/{0}{1}/.ssh/:/root/.ssh/:ro",
        $env:SystemDrive.Replace(':','').ToLower(),
        $env:HOMEPATH.Replace('\','/')
    )
    docker run -it --rm `
        -w /root `
        -v $dotSshVolume `
        --volumes-from ssh-agent `
        -e SSH_AUTH_SOCK=/sshagent/sshagent.sock `
        vpommier/ssh-agent:latest ssh-add $args
}

function Start-Fleetctl {
    [string]$unitsDir = "/root/units/"
    [string]$unitsDirVolume = [string]::Format(
        "{0}:{1}:ro",
        (ToLinuxPath -str $PWD.Path),
        $unitsDir
    )
    [string]$sshKnownHostsVolume = [string]::Format(
        "/{0}{1}/.ssh/known_hosts:/root/.fleetctl/known_hosts:rw",
        $env:SystemDrive.Replace(':','').ToLower(),
        $env:HOMEPATH.Replace('\','/')
    )
    docker run -it --rm `
        -w $unitsDir `
        -v $unitsDirVolume `
        -v $sshKnownHostsVolume `
        --volumes-from ssh-agent `
        -e SSH_AUTH_SOCK=/sshagent/sshagent.sock `
        vpommier/fleetctl $args
}#>
