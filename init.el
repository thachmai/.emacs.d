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


; evil-leader
; must appear before (require 'evil)
(use-package evil-leader
  :commands (evil-leader-mode)
  :ensure evil-leader
  :demand evil-leader
  :init (global-evil-leader-mode)
  :config
  (progn
    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key "q" 'kill-buffer-and-window)
    (evil-leader/set-key "|" 'split-window-horizontally)
    (evil-leader/set-key "-" 'split-window-vertically)
    (evil-leader/set-key "b" 'ibuffer)
    (evil-leader/set-key "x" 'helm-M-x)
    )
  )

(require 'evil)

; magit
; heml
; TODO, since they seem to work only with emacs 24.4 and the default emacs from apt is 24.3

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
; doesn't work, it messes up the j key in insert mode
;(define-key evil-insert-state-map (kbd "jk") 'evil-normal-state)

; simulating vinegar
(require 'dired-x)
(define-key evil-normal-state-map (kbd "-") 'dired-jump)
; dired bindings
(defun my-dired-up-directory ()
  "Take dired up one directory, but behave like dired-find-alternate-file"
  (interactive)
  (let ((old (current-buffer)))
    (dired-up-directory)
    (kill-buffer old)
    ))
(evil-define-key 'normal dired-mode-map "h" 'dired-up-directory)
(evil-define-key 'normal dired-mode-map "l" 'dired-find-alternate-file)
(evil-define-key 'normal dired-mode-map "o" 'dired-sort-toggle-or-edit)
(evil-define-key 'normal dired-mode-map "v" 'dired-toggle-marks)
(evil-define-key 'normal dired-mode-map "m" 'dired-mark)
(evil-define-key 'normal dired-mode-map "u" 'dired-unmark)
(evil-define-key 'normal dired-mode-map "U" 'dired-unmark-all-marks)
(evil-define-key 'normal dired-mode-map "c" 'dired-create-directory)
(evil-define-key 'normal dired-mode-map "n" 'evil-search-next)
(evil-define-key 'normal dired-mode-map "N" 'evil-search-previous)
(evil-define-key 'normal dired-mode-map "q" 'kill-this-buffer)
(evil-define-key 'normal dired-mode-map "h" 'my-dired-up-directory)

; fixing ibuffer bindings
(eval-after-load 'ibuffer
  '(progn
     (evil-set-initial-state 'ibuffer-mode 'normal)
     (evil-define-key 'normal ibuffer-mode-map
       (kbd "m") 'ibuffer-mark-forward
       (kbd "t") 'ibuffer-toggle-marks
       (kbd "u") 'ibuffer-unmark-forward
       (kbd "=") 'ibuffer-diff-with-file
       (kbd "j") 'ibuffer-jump-to-buffer
       (kbd "M-g") 'ibuffer-jump-to-buffer
       (kbd "M-s a C-s") 'ibuffer-do-isearch
       (kbd "M-s a M-C-s") 'ibuffer-do-isearch-regexp
       ;; ...
       )
     )
  )


(visual-line-mode 1)
; this stays at the bottom per https://nathantypanski.com/blog/2014-08-03-a-vim-like-emacs-config.html
(evil-mode 1)

(put 'dired-find-alternate-file 'disabled nil)
