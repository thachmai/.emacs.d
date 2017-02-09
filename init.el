(require 'package)
(package-initialize)
(setq package-enable-at-startup nil)

(add-to-list 'load-path (concat user-emacs-directory "config"))
(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
(require 'use-package)
(require 'evil)

; evil-leader
(use-package evil-leader
  :commands (evil-leader-mode)
  :ensure evil-leader
  :demand evil-leader
  :init
  (global-evil-leader-mode)
  :config
  (progn
    (evil-leader/set-leader " ")
    (evil-leader/set-key "q" 'kill-buffer-and-window)
    )
  )

; elisp-slime-nav
(require 'elisp-slime-nav)
(defun elisp-hook ()
  (elisp-slime-nav-mode)
  (turn-on-eldoc-mode))

(add-hook 'emacs-lisp-mode-hook 'elisp-hook)

(evil-define-key 'normal emacs-lisp-mode-map (kbd "K") 'elisp-slime-nav-describe-elisp-thing-at-point)

; windows nav
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

; esc "rebind"
(define-key evil-insert-state-map (kbd "jk") 'evil-normal-state)

; this stays at the bottom per https://nathantypanski.com/blog/2014-08-03-a-vim-like-emacs-config.html
(evil-mode 1)

