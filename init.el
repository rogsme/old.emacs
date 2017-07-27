;; Basic: User
(setq user-full-name "Roger González")
(setq user-mail-address "rogergonzalez21@gmai.com")

;; Basic: Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:foreground "#030303" :background "#6d0204" :box nil))))
 '(mode-line-buffer-id ((t (:foreground "#000000" :bold t))))
 '(mode-line-inactive ((t (:foreground "#ffffff" :background "#5d6365" :box nil))))
 '(powerline-active1 ((t (:foreground "#f9f9f9" :background "#ff6365" :box nil))))
 '(powerline-active2 ((t (:foreground "#f9f9f9" :background "#5d6365" :box nil))))
 '(powerline-arrow-shape (quote arrow)))

;; Theme
(load-theme 'badwolf t)

;; Saves emacs backups in other folder
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.emacs_backups"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

;; Line number
(global-linum-mode 1)
(line-number-mode 1)

;; Column number
(column-number-mode 1)
(ac-config-default)

;; WhiteSpace Cleanup
(global-whitespace-cleanup-mode)

;; Auto revert mode (Updating buffers when changed on disk)
(global-auto-revert-mode)

;; Selection highlight
(delete-selection-mode 1)

;; Parentesis highlight
(show-paren-mode 1)

;; NO scrollbar, NO toolbar NO menubar
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(horizontal-scroll-bar-mode -1)

;; Basic: Maximize Buffer
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; F5 = Goto
(global-set-key [f5] 'goto-line)

;; Removes mouse from code
(mouse-avoidance-mode "animate")

;; Web Mode: Begin
;; JSX configs: http://cha1tanya.com/2015/06/20/configuring-web-mode-with-jsx.html
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js[x]?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.es6\\'" . web-mode))


;; use web-mode for .jsx files
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

(setq web-mode-content-types-alist
      '(("jsx" . "\\.js[x]?\\'")
        ("javascript" . "\\.es6?\\'")))

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "js")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

;; WebMode: Style-Gook
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-css-colorization t)
  (setq web-mode-enable-auto-expanding t)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t)
  )

;; WebMode: Emmet-Hook
(add-hook 'web-mode-before-auto-complete-hooks
          '(lambda ()
             (let ((web-mode-cur-language
                    (web-mode-language-at-pos)))
               (if (string= web-mode-cur-language "css")
                   (setq emmet-use-css-transform t)
                 (setq emmet-use-css-transform nil)))))

;; Indent
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq js-indent-level 2)
(setq js-highlight-level 3)

(add-hook 'web-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'html-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'web-mode-hook 'my-web-mode-hook)
(add-hook 'web-mode-hook #'emmet-mode)
(setq emmet-preview-default t)
(add-hook 'web-mode-hook 'rainbow-mode)

;; Tabs with spaces
(setq-default indent-tabs-mode nil)

;; Powerline
(require 'powerline)
(powerline-default-theme)


;; Org-Mode
;; Auto Org-Mode

(setq org-todo-keyword-faces
      '(
        ("SOMEDAY" . (:foreground "blue"))
        ("CANCELED" . (:foreground "yellow"))
        ("WAITING" . (:foreground "purple"))
        ("NEXT DAY" . (:foreground "white"))
        ("DONE" . (:foreground "green"))
        ))
(setq org-todo-keywords
      '((sequence "TODO" "WAITING" "SOMEDAY" "CANCELED" "NEXT DAY" "DONE")))

;; Org-clock
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

;; Delete selection mode
(delete-selection-mode 1)

;; NeoTree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Magit
(global-set-key [f7] 'magit-status)
(require 'magit-gitflow)
(add-hook 'magit-mode-hook 'turn-on-magit-gitflow)

;; Desktop save Mode
(desktop-save-mode 1)

;; FlyCheck configs
;; More help: http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html#configuring_emacs
;; http://www.flycheck.org/manual/latest/index.html
;; http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html
(require 'flycheck)

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
          '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
          '(json-jsonlist)))

;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

;; https://github.com/purcell/exec-path-from-shell
;; only need exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; YASnippets
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (react-snippets yasnippet whitespace-cleanup-mode web-mode web-beautify scss-mode sass-mode rjsx-mode rainbow-mode rainbow-delimiters projectile project-explorer powerline nyan-mode neotree markdown-mode magit-gitflow kooten-theme json-mode jedi indent-guide geeknote flycheck exec-path-from-shell emmet-mode bundler badwolf-theme aggressive-indent))))
