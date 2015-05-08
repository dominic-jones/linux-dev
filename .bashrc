# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#Git
#Shows + for staged, * for unclean repo. Slow on first use
export GIT_PS1_SHOWDIRTYSTATE=1
#Gives Git branch in command line
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '

#Say
alias say="echo $1 | espeak -ven-rp+f1 -s250 2>/dev/null"
function report() {
  say $1 ;
  notify-send $1 ;
}

#Main
export appsDir=~/apps

#Maven
export M2_HOME=$appsDir/apache-maven-3.3.1
export M2_305_HOME=$appsDir/apache-maven-3.0.5
export M2_L_HOME=$appsDir/apache-maven
export MVN_BIN=$M2_HOME/bin/mvn
alias mvn305='export M2_HOME=$M2_305_HOME'
alias mvnl='export M2_HOME=$M2_L_HOME'
alias mvn=$MVN_BIN

function mvn1() { mvn $@ ;}
function mvn305 { $M2_305_HOME/bin/mvn $@ ;}
function mci() {
	mvn1 clean install $@ ;
	let result=$? ;
	[ $result -eq 130 ] && report cancelled && return $result ;
	[ $result -ne 0 ]   && report failure && return $result ;
	[ $result -eq 0 ]   && report success && return $result ;
}

function mcisa() {
	mci -DskipTests -DskipITests -DskipAllTests -Dskip.checkstyle -Dcheckstyle.skip -Dpmd.skip -Djacoco.skip -T3 $@ ;
	return $? ;
}

function mcirt() {
	mci -Dtrinidad.run.suite=$@ ;
	return $? ;
}

function mvnDebug() {
	$M2_HOME/bin/mvnDebug $@ ;
}

alias mcar="mvn1 clean cargo:run $@"
alias mtom="mvn1 clean tomcat7:run-war $@"
alias mver="mvn1 versions:display-dependency-updates $@ "
alias mjac="mci clean verify jacoco:check\
  -Djacoco.instruction.covered-ratio=0.99\
  -Djacoco.branch.covered-ratio=0.99\
  -Djacoco.line.covered-ratio=0.99\
  -Djacoco.complexity.covered-ratio=0.99\
  -Djacoco.method.covered-ratio=0.99\
  -Djacoco.class.covered-ratio=0.99 $@ "

#p4merge
#function p4merge() { $appsDir/p4v/bin/p4merge $@ ;}
alias p4merge=$appsDir/p4merge

#Git
alias grc="git rebase --continue"
alias gra="git rebase --abort"
alias gpr="git pull --rebase"
alias gfa="git fetch --all"
alias gst="git status"

#reload bashrc
alias bashrl=". ~/.bashrc"

#Apps
alias ack=ack-grep
alias mtree="mvn dependency:tree"
alias idea="$appsDir/idea $@"
alias oxygen="$appsDir/oxygen $@"
alias smartgit="$appsDir/smartgit $@"
alias vlt="$appsDir/vlt $@"
export CHROMIUM_FLAGS="--touch-devices=123"

#Cool
alias hosthere="python -m SimpleHTTPServer 9999"

#Dev links
dev=~/dev
cortex="$dev/cortex"
commerce="$dev/commerce-engine"
itest=$cortex/cortex-dce/itests
m2=/home/dom/.m2
alias dev="cd $dev"
alias cortex="cd $cortex"
alias itestc="chromium cortex-dce/itests/target/cucumber-html-report/index.html"
alias itestl="geany $itest/target/tomcat7x/container/target/logs/elasticpath-relos.log"
alias itestr="chromium $itest/target/site/fitresults/DigitalCommerceApiTests.html"
alias ser="mvn generate-resources prepare-package cargo:run -pl cortex-dce/cortex-dce-studio-webapp/ -P h2-local"
alias reindex="mvn ep-core-tool:request-reindex"
alias psan='mvn clean verify -P phantomjs -s ./maven/ci-settings.xml -Dcucumber.options="--tags @sanity"'
alias psmoke='mvn clean verify -P phantomjs -s ./maven/ci-settings.xml -Dcucumber.options="--tags @smoketest"'

#Java exports
export JAVA_7=/usr/lib/jvm/jdk1.7.0_60
export JAVA_8=/usr/lib/jvm/jdk1.8.0_45
export JAVA_HOME=$JAVA_8
export IDEA_JDK=$JAVA_8
export JAVA_TOOL_OPTIONS="-Djava.xml.accessExternalSchema=all -XX:MaxPermSize=512m"
export MVN_OPTS="-Djava.xml.accessExternalSchema=all"
function java7() {
	export JAVA_HOME=$JAVA_7 ;
	alias java=$JAVA_HOME/bin/java ;
	alias javap=$JAVA_HOME/bin/javap ;
}
function java8() {
	export JAVA_HOME=$JAVA_8 ;
	alias java=$JAVA_HOME/bin/java ;
	alias javap=$JAVA_HOME/bin/javap ;
}
alias java=${JAVA_HOME}/bin/java

#XML
function xh() {
	xmllint --format $1 | pygmentize -l xml ;
}

#Keyboard
#alt+caps
setxkbmap -option grp:caps_switch 

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

pathadd $JAVA_HOME/bin
pathadd $MAVEN_HOME/bin

