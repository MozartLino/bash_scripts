alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'
alias bers="be rails s"
alias berc="be rails c"

# Spree extensions
alias ecom='cd ~/Desenvolvimento/bluesoft-ecommerce/'
alias ecomm='ecom && gc master'
alias ekimi='cd ~/Desenvolvimento/spree_kimi/'
alias ekimim='ekimi && gc master'
alias epags='cd ~/Desenvolvimento/spree_pagseguro_oficial'
alias ecore='cd ~/Desenvolvimento/spree_ecommerce_core'
alias swl='cd ~/Desenvolvimento/spree_waiting_list/'

commit_all(){
	
	echo ' >> init commit all changes'

	update_pagseguro $1
	update_kimi $1
	update_core $1
	update_ecommerce $1

	echo ' << commit finish with success'

}

update_ecommerce() {
	echo ':: ecommerce :: >>'

	ecomm 

	bu

	has_change

	if [ $? == 1 ]; then 
	  echo 'has change'

	  commit_changes $1
	  copy_changes_ecommerce_to_blue_theme

	else 
	  echo "doesn't have change"
	fi

	echo ':: ecommerce :: <<'
}

copy_changes_ecommerce_to_blue_theme() {
	gc bluesoft-theme
	git merge master
	git checkout HEAD -- Gemfil*
	bu
	git add .
	git commit
	git push
	gc master
}

update_pagseguro() {
	echo ':: pagseguro :: >>'

	epags

	has_change

	if [ $? == 1 ]; then 
	  echo 'has change'
	  commit_changes $1
	else 
	  echo "doesn't have change"
	fi

	echo ':: pagseguro :: <<'
}

update_core() {
	echo ':: core :: >>'

	ecore

	has_change

	if [ $? == 1 ]; then
	  echo 'has change'
	  commit_changes $1
	else 
	  echo "doesn't have change"
	fi

	echo ':: core :: <<'
}

update_kimi() {

	echo ':: kimi :: >>'

	ekimim

	has_change

	if [ $? == 1 ]; then 
	  echo 'has change'
	  commit_changes $1
	  copy_changes_kimi_to_blue_theme
	else 
	  echo "doesn't have change"
	fi

	echo ':: kimi :: <<'
}

commit_changes() {
	echo 'commit changes'
	git add .
	git commit -m $1
	git push
}

copy_changes_kimi_to_blue_theme() {
	echo 'copy changes to bluesoft-theme'
	gc bluesoft-theme
	git merge master 
	git push
	gc master
}

has_change() {
	if [ -n "$(git status --porcelain)" ]; then 
	  return 1
	else 
	  return 0
	fi
}