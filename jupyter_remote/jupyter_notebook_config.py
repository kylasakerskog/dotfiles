c = get_config()

# Notebook上でplotを表示できるようにする
c.IPKernelApp.pylab = 'inline'
# 全てのIPから接続を許可
c.NotebookApp.ip = '0.0.0.0'
# IPython notebookのログインパスワード
c.NotebookApp.password = 'sha1:774bb9c5e580:1d689e787b8a96b92f042647ead0ae2750abeb62'
# 起動時にブラウザを起動させるかの設定
c.NotebookApp.open_browser = False
# ポート指定
c.NotebookApp.port = 9999

