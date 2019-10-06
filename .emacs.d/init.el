(setq make-backup-files nil)
(setq auto-save-default nil)
(setq-default tab-width 2 indent-tabs-mode nil)
(setq kill-whole-line t)
(setq mac-option-modifier 'meta)
(setq whitespace-style
     '(tabs tab-mark spaces space-mark))
(put 'upcase-region 'disabled nil)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(setq package-archives
     '(("gnu" . "http://elpa.gnu.org/packages/")
       ("melpa" . "http://melpa.org/packages/")
       ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

(require 'whitespace)
(global-whitespace-mode 1)
(set-face-foreground 'whitespace-space "LightSlateGray")
(set-face-background 'whitespace-space "DarkSlateGray")
(set-face-foreground 'whitespace-tab "LightSlateGray")
(set-face-background 'whitespace-tab "DarkSlateGray")

(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
     '((space-mark ?\x3000 [?\□])
       (tab-mark   ?\t   [?\xBB ?\t])
       ))
(require 'company)
(global-company-mode) ; 全バッファで有効にする                                                                       
(setq company-transformers '(company-sort-by-backend-importance)) ;; ソート順                                        
(setq company-idle-delay 0) ; デフォルトは0.5                                                                        
(setq company-minimum-prefix-length 3) ; デフォルトは4                                                               
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る                          
(setq completion-ignore-case t)
(setq company-dabbrev-downcase nil)
(global-set-key (kbd "C-M-i") 'company-complete)
(define-key company-active-map (kbd "C-n") 'company-select-next) ;; C-n, C-pで補完候補を次/前の候補を選択            
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates) ;; C-sで絞り込む                              
(define-key company-active-map (kbd "C-i") 'company-complete-selection) ;; TABで候補を設定                           
(define-key company-active-map [tab] 'company-complete-selection) ;; TABで候補を設定                                 
(define-key company-active-map (kbd "C-f") 'company-complete-selection) ;; C-fで候補を設定                           
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete) ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う    

;; yasnippetとの連携                                                                                                 
(defvar company-mode/enable-yas t
 "Enable yasnippet for all backends.")
(defun company-mode/backend-with-yas (backend)
 (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
     backend
   (append (if (consp backend) backend (list backend))
           '(:with company-yasnippet))))
(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (markdown-mode restart-emacs company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq inhibit-startup-message t)

;; シンボリックリンクの読み込みを許可
(setq vc-follow-symlinks t)
;; シンボリックリンク先のVCS内で更新が入った場合にバッファを自動更新
(setq auto-revert-check-vc-info t)

(defun scss-custom ()
  (setq indent-tabs-mode nil)
  (setq css-indent-offset 2)
  )

(add-hook 'scss-mode-hook
  '(lambda() (scss-custom)))

;; markdown-mode
;; m-x package-list-package, install markdown-mode | once
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
;; (setq auto-mode-alist
;;       (append '(("\\.md$" . yatex-mode)
;;                 ("\\.txt$" . yatex-mode)) auto-mode-alist))
