# dotfiles

## zsh

oh-my-zsh インストール方法

```bash
# oh-my-zsh をインストール
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
 
# zsh コマンドのシンタックスハイライトプラグインをインストール
 git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  
# zsh コマンドの補完プラグインをインストール
  git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
```
