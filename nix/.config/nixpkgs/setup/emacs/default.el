;;;; init.el --- Peel's Essential Emacs Lisp

;;; Commentary:
;;; Work in progress.  An attempt for a clean start of nix-managed config.

;;; Code:
;;; ▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂

(setq gc-cons-threshold 64000000)
(add-hook 'after-init-hook (lambda ()
                             ;; restore after startup
                             (setq gc-cons-threshold 800000)))

;; package.el ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁
(require 'package)
(package-initialize 'noactivate)

(eval-when-compile
  (require 'use-package))

(setq-default use-package-always-defer t
              use-package-always-ensure t)

(use-package diminish
  :init (require 'diminish))


;; navigation ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁

(use-package winner
  :config (winner-mode 1))

;; ..................................................................... jumping
(use-package avy
  :after hydra
  :bind ("C-'" . hydra-avy/body)
  :init
  (require 'hydra)
  :config
  (defhydra hydra-avy (:color teal)
    ("j" avy-goto-char)
    ("k" avy-goto-word-1)
    ("l" avy-goto-line)
    ("s" avy-goto-char-timer)
    ("f" counsel-find-file)
    ("q" nil)))


;; completion ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁
(use-package company
  :bind ("<C-tab>" . company-complete)
  :diminish company-mode
  :commands (company-mode global-company-mode)
  :defer 1
  :config
  (setq company-require-match nil
	    company-selection-wrap-around t)
  (global-company-mode))


;; ivy ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁

;; ........................................................................ core
(use-package ivy
  :defer 1
  :bind (("C-c C-r" . ivy-resume)
	     ([remap list-buffers] . ivy-switch-buffer)
	     ([remap switch-to-buffer] . ivy-switch-buffer)
	     ([remap switch-to-buffer-other-window] . ivy-switch-buffer-other-window)
         ("C-c C-f" . ivy-recentf)
         :map ivy-minibuffer-map
         ("C-j" . ivy-call))
  :diminish ivy-mode
  :commands ivy-mode
  :config
  (ivy-mode 1)
  (setq ivy-re-builders-alist
	    '((t . ivy--regex-fuzzy))))

;; ...................................................................... counsel
(use-package counsel
  :commands (counsel-descbinds)
  :bind (([remap execute-extended-command] . counsel-M-x)
	     ([remap find-file] . counsel-find-file)
	     ([remap find-library] . counsel-find-library)
	     ([remap describe-function] . counsel-describe-function)
	     ([remap describe-variable] . counsel-describe-variable)
	     ([remap describe-bindings] . counsel-descbinds)
	     ([remap describe-face]  . counsel-describe-faces)
	     ([remap list-faces-display] . counsel-faces)
	     ([remap imenu] . counsel-imenu)
	     ([remap load-library] . counsel-load-library)
	     ([remap load-theme] . counsel-load-theme)
	     ([remap yank-pop] . counsel-yank-pop)
	     ([remap info-lookup-symbol] . counsel-info-lookup-symbol)
	     ([remap pop-to-mark-command] . counsel-mark-ring)
	     ([remap bookmark-jump] . counsel-bookmark)
	     ("C-c g" . counsel-git)
	     ("C-c j" . counsel-git-grep)
	     ("M-y" . counsel-yank-pop)
	     ("C-c i 8" . counsel-unicode-char)
         ("C-c r" . counsel-rg)
	     ("C-c d" . counsel-descbinds)))

;; ...................................................... projectile integration
(use-package counsel-projectile
  :after (counsel projectile)
  :commands counsel-projectile
  :hook projectile-mode
  :config
  (counsel-projectile-mode))

;; ...................................................................... search
(use-package swiper
  :bind ("C-s" . swiper))

;; syntax checking ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁
(use-package flycheck
  :hook (prog-mode . flycheck-mode)
  :diminish flycheck-mode " ✓")

;; git ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁
(use-package magit
  :if (executable-find "git")
  :bind (("C-x g" . magit-status)
         ("C-x G" . magit-dispatch-popup))
  :custom
  (magit-completing-read-function 'ivy-completing-read))

;; TODO git-timemachine
;; TODO gitignore-mode

;; project management ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁
(use-package projectile
  :commands projectile-mode
  :bind-keymap ("C-c p" . projectile-command-map)
  :defer 5
  :diminish projectile-mode
  :custom
  (projectile-completion-system 'ivy)
  :config
  (projectile-mode))

;; ui ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁

;; ................................................................... highlight
(use-package highlight-symbol
  :diminish highlight-symbol-mode
  :commands highlight-symbol
  :bind ("s-h" . highlight-symbol))

;; ................................................................. visual undo
(use-package undo-tree
  :defer 5
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode)
  (setq undo-tree-visualizer-diff t)
  (setq undo-tree-visualizer-timestamps t)
  :bind ("s-/" . undo-tree-visualize))


;; other ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁
(use-package editorconfig
  :defer 1
  :diminish editorconfig-mode
  :config (editorconfig-mode 1))

;; files ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁
(use-package dired
  :ensure nil
  :config
  (setq dired-dwim-target t
        dired-recursive-deletes t
        dired-use-ls-dired nil
        delete-by-moving-to-trash t))

;; bindings ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁

;; ....................................................................... popup
(use-package which-key
  :defer 1
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.5
        which-key-sort-order 'which-key-prefix-then-key-order)
  (which-key-add-key-based-replacements
    "C-c !" "flycheck"
    "C-c p" "projectile"
    "C-c i" "unicode"
    "C-c &" "yas")
  (which-key-add-major-mode-key-based-replacements 'scala-mode
    "C-c C-b" "ensime/build"
    "C-c C-c" "ensime/current"
    "C-c C-d" "ensime/debug"
    "C-c C-r" "ensime/refactor"
    "C-c C-v" "ensime/misc")
  (which-key-mode))


;; ....................................................................... setup
;; hydra
(use-package hydra
  :ensure t
  :demand t)

;; languages ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁

;; ..................................................................... generic
;; indentation
(setq-default indent-tabs-mode nil
	          tab-width 4
	          fill-column 80)

(use-package noflet)
(use-package aggressive-indent
  :hook (prog-mode . aggressive-indent-mode)
  :diminish (aggressive-indent-mode . " "))

;; rainbow
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package rainbow-identifiers
  :hook (prog-mode . rainbow-identifiers-mode))

;; git-gutter
(use-package diff-hl
  :hook (prog-mode . diff-hl-mode)
  :diminish diff-hl-mode)

;; gtags
(use-package ggtags
  :if (executable-find "global")
  :hook ((nix-mode . ggtags-mode) (scala-mode . ggtags-mode))
  :diminish (ggtags-mode . " "))

(use-package counsel-gtags
  :defer 1
  :diminish counsel-gtags-mode
  :hook (ggtags-mode . counsel-gtags-mode))

(use-package dumb-jump
  :after hydra
  :bind ("s-." . dumb-jump-hydra/body)
  :init (require 'hydra)
  :config
  (defhydra dumb-jump-hydra (:color blue :columns 3)
    "Dumb Jump"
    ("j" dumb-jump-go "Go")
    ("o" dumb-jump-go-other-window "Other window")
    ("e" dumb-jump-go-prefer-external "Go external")
    ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
    ("i" dumb-jump-go-prompt "Prompt")
    ("l" dumb-jump-quick-look "Quick look")
    ("b" dumb-jump-back "Back")))

(use-package show-paren
  :ensure nil
  :init (show-paren-mode 1))

(use-package expand-region
  :bind (("C-c v" . er/expand-region)))

(use-package smartparens
  :after hydra
  :hook (prog-mode . smartparens-strict-mode)
  :diminish smartparens-mode
  :bind (("C-c k" . peel-smartparens/body)
         :map smartparens-strict-mode-map
         ;; A fill paragraph in strict mode
         ("M-q" . sp-indent-defun))
  :init
  (require 'hydra)
  :config
  ;; Hydra for Smartparens
  (defhydra peel-smartparens (:hint nil)
    "
Sexps (quit with _q_)

^Nav^            ^Barf/Slurp^                 ^Depth^
^---^------------^----------^-----------------^-----^-----------------
_f_: forward     _→_:         slurp forward   _R_: splice
_b_: backward    _←_:         barf forward    _r_: raise
_u_: backward ↑  _C-<right>_:  slurp backward  _↑_: raise backward
_d_: forward ↓   _C-<left>_:   barf backward   _↓_: raise forward
_p_: backward ↓
_n_: forward ↑

^Kill^           ^Misc^                       ^Wrap^
^----^-----------^----^-----------------------^----^------------------
_w_: copy        _j_: join                    _(_: wrap with ( )
_k_: kill        _s_: split                   _{_: wrap with { }
^^               _t_: transpose               _'_: wrap with ' '
^^               _c_: convolute               _\"_: wrap with \" \"
^^               _i_: indent defun"
    ("q" nil)
    ;; Wrapping
    ("(" (lambda (_) (interactive "P") (sp-wrap-with-pair "(")))
    ("{" (lambda (_) (interactive "P") (sp-wrap-with-pair "{")))
    ("'" (lambda (_) (interactive "P") (sp-wrap-with-pair "'")))
    ("\"" (lambda (_) (interactive "P") (sp-wrap-with-pair "\"")))
    ;; Navigation
    ("f" sp-forward-sexp )
    ("b" sp-backward-sexp)
    ("u" sp-backward-up-sexp)
    ("d" sp-down-sexp)
    ("p" sp-backward-down-sexp)
    ("n" sp-up-sexp)
    ;; Kill/copy
    ("w" sp-copy-sexp)
    ("k" sp-kill-sexp)
    ;; Misc
    ("t" sp-transpose-sexp)
    ("j" sp-join-sexp)
    ("s" sp-split-sexp)
    ("c" sp-convolute-sexp)
    ("i" sp-indent-defun)
    ;; Depth changing
    ("R" sp-splice-sexp)
    ("r" sp-splice-sexp-killing-around)
    ("<up>" sp-splice-sexp-killing-backward)
    ("<down>" sp-splice-sexp-killing-forward)
    ;; Barfing/slurping
    ("<right>" sp-forward-slurp-sexp)
    ("<left>" sp-forward-barf-sexp)
    ("C-<left>" sp-backward-barf-sexp)
    ("C-<right>" sp-backward-slurp-sexp))
  (use-package smartparens-config
    :ensure nil
    :demand))

(use-package prog-mode
  :ensure nil
  :hook (prog-mode . prettify-symbols-mode)
  :preface (load (locate-file "pragmata.el" load-path) 'noerror))

;; ..................................................................... haskell
;; TODO

;; ......................................................................... nix
(use-package nix-mode
  :mode "\\.nix\\'")

;; ....................................................................... dhall
(use-package dhall-mode
  :disabled
  :mode "\\.dhall\\'")

;; ...................................................................... docker
(use-package dockerfile-mode)

;; ...................................................................... elixir
;; TODO

;; ...................................................................... shells
;; TODO

;; ..................................................................... clojure
;; TODO

;; ........................................................................ yaml
(use-package yaml-mode
  :mode ("\\.yml\\'" "\\.yaml\\'"))

;; ....................................................................... scala
(use-package ensime
  :mode ("\\.scala\\'" "\\.sc\\'" "\\.sbt\\'")
  :preface
  (setq ensime-search-interface 'ivy
	    ensime-startup-notification nil
        ensime-eldoc-hints 'all)
  (defun ensime-gen-and-restart()
    "Regenerate `.ensime' file and restart the ensime server."
    (interactive)
    (progn
      (sbt-command ";ensimeConfig;ensimeConfigProject")
      (ensime-shutdown)
      (ensime))))

(use-package scala-mode
  :mode ("\\.scala\\'" "\\.sc\\'" "\\.sbt\\'")
  :diminish (scala-mode . " ")
  :after noflet
  :interpreter
  ("scala" . scala-mode)
  :bind ("C-c C-v f" . scalafmt/format-file)
  :config
  (setq scala-indent:align-forms t
        scala-indent:align-parameters t
        scala-indent:default-run-on-strategy scala-indent:operator-strategy)
  :preface
  (require 'noflet)
  (defadvice scala-indent:indent-code-line (around retain-trailing-ws activate)
    "Keep trailing-whitespace when indenting."
    (noflet ((scala-lib:delete-trailing-whitespace ()))
      ad-do-it))
  (defun scalafmt/format-file ()
    "Run scalafmt on the current file"
    (interactive)
    (let ((default-directory (projectile-project-root))
          (scalafmt-cmd (format "/usr/bin/env scalafmt -i -f %s"
                                (shell-quote-argument (buffer-file-name)))))
      (message "Running %s..." scalafmt-cmd)
      (shell-command scalafmt-cmd)
      (revert-buffer t t t))))


;; .......................................................................... js
;;(use-package tide)
(use-package rjsx-mode
  :config
  (flycheck-add-mode 'javascript-eslint 'rjsx-mode))
(use-package prettier-js)
(use-package web-mode
  :ensure smartparens
  :ensure rainbow-delimiters
  :ensure aggressive-indent
  :ensure prettier-js
  :ensure rjsx-mode
  :mode ("\\.html?\\'" "\\.jsx?" "\\.css\\'" "\\.scss\\'"))


;; .................................................................. restclient
(use-package restclient
  :diminish (restclient-mode . " ")
  :mode (("\\.http\\'" . restclient-mode)
	     ("\\.rest\\'" . restclient-mode)
	     ("\\.restclient\\'" . restclient-mode)))


;; ................................................................... terraform
(use-package terraform-mode
  :mode ("\\.tf\\'"))


;; .................................................................... markdown
(use-package markdown-mode
  :mode (("\\.markdown\\'" . markdown-mode)
         ("\\.md\\'" . markdown-mode))
  :diminish (markdown-mode . " "))


;; org ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁
;; TODO
(use-package org
  :ensure nil
  :config
  ;; jekyll 
  (autoload 'endless/export-to-blog "jekyll-once")
  (setq org-jekyll-use-src-plugin t)
  (setq endless/blog-base-url "https://codearsonist.com/")
  (setq endless/blog-dir (expand-file-name "~/wrk/blog/"))
  ;; disabled for now: (require 'ox-jekyll-subtree)
  )

;; builtins ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁

;; ...................................................................... server
(use-package server
  :disabled
  :init (server-start))


;; ....................................................................... eldoc
(use-package eldoc
  :ensure nil
  :diminish (eldoc-mode . " ")
  :demand
  :hook ((emacs-lisp-mode . eldoc-mode)
	     (eshell-mode . eldoc-mode)
	     (gtags-mode . eldoc-mode))
  :config (eldoc-mode t))

;; ...................................................................... eshell
(use-package eshell
  :ensure nil
  :bind (("C-c e" . eshell)
         ("C-c E" . eshell-new))
  :config (setq eshell-banner-message "")
  :init
  (defun eshell-new()
    "Open a new instance of eshell."
    (interactive)
    (eshell 'N)))


;; .................................................................. autorevert
(use-package autorevert
  :ensure nil
  :commands global-auto-revert-mode
  :demand
  :config (global-auto-revert-mode t))


;; ............................................................ delete selection
(use-package delsel
  :ensure nil
  :demand
  :commands delete-selection-mode
  :config (delete-selection-mode t))


;; ui ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁

;; ...................................................................... themes
(use-package peel-frame
  :if window-system
  :ensure nil
  :requires gotham-theme
  :requires apropospriate-theme
  :requires nord-theme
  :preface
  (add-hook 'focus-in-hook #'peel/load-font)
  (add-hook 'focus-in-hook #'peel/load-theme)
  (add-hook 'focus-in-hook #'peel/load-ui)
  
  (defvar dark-theme 'gotham)
  (defvar semi-dark-theme 'nord)
  (defvar light-theme 'apropospriate-light)
  (defvar default-theme semi-dark-theme)
  
  (defun peel/load-theme ()
    (load-theme default-theme t)
    (remove-hook 'focus-in-hook #'peel/load-theme))

  (defun peel/load-font ()
    "Load default font."
    (defvar default-font "PragmataPro")
    (set-face-attribute 'default nil :height 180)
    (setq-default line-spacing 7)
    (set-frame-font default-font))
  
  (defun peel/load-ui ()
    "Remove UI bars."
    (tool-bar-mode -1)
    (scroll-bar-mode -1)
    (blink-cursor-mode -1)
    ;;(set-frame-parameter nil 'undecorated t)
    (when (not (memq window-system '(mac ns)))
      (menu-bar-mode -1))
    (remove-hook 'focus-in-hook #'peel/load-ui))
  
  (defun dark-theme ()
    "Load dark theme."
    (interactive)
    (load-theme dark-theme t))

  (defun semi-dark-theme ()
    "Load semi-dark theme."
    (interactive)
    (load-theme semi-dark-theme t))

  (defun light-theme ()
    "Load light theme."
    (interactive)
    (load-theme light-theme t))
  :config
  
  (use-package nord-theme
    :preface
    (add-to-list 'custom-theme-load-path
                 (file-name-directory (locate-library "nord-theme"))))

  (use-package gotham-theme
    :preface
    (add-to-list 'custom-theme-load-path
                 (file-name-directory (locate-library "gotham-theme"))))

  (use-package apropospriate-theme
    :preface
    (add-to-list 'custom-theme-load-path
                 (file-name-directory (locate-library "apropospriate-theme")))))

;; .................................................................... unclutter
(use-package emacs
  :defer 0
  :bind ("C-z" . kill-whole-line)
  :init
  (setq  inhibit-startup-screen t
         initial-scratch-message nil
         make-backup-files nil
         frame-resize-pixelwise t
         pop-up-windows nil
         column-number-mode t
         confirm-kill-emacs 'yes-or-no-p
         echo-keystrokes 0.1
         apropos-do-all t
         visible-bell nil))


;; ............................................................. fix awkwardness
(fset 'yes-or-no-p 'y-or-n-p)

(setq ring-bell-function (lambda ()
                           (invert-face 'mode-line)
                           (run-with-timer 0.1 nil 'invert-face 'mode-line)))

;;; ▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂
;;; default.el ends here
