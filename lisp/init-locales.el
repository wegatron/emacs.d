;;; init-locales.el --- Configure default locale -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defun sanityinc/utf8-locale-p (v)
  "Return whether locale string V relates to a UTF-8 locale."
  (and v (string-match-p "UTF-8" v)))

(defun sanityinc/locale-is-utf8-p ()
  "Return t iff the \"locale\" command or environment variables prefer UTF-8."
  (or (sanityinc/utf8-locale-p (and (executable-find "locale") (shell-command-to-string "locale")))
      (sanityinc/utf8-locale-p (getenv "LC_ALL"))
      (sanityinc/utf8-locale-p (getenv "LC_CTYPE"))
      (sanityinc/utf8-locale-p (getenv "LANG"))))

(when (or window-system (sanityinc/locale-is-utf8-p))
  (set-language-environment 'utf-8)
  (setq locale-coding-system 'utf-8)
  (set-selection-coding-system (if (eq system-type 'windows-nt) 'utf-16-le 'utf-8))
  (prefer-coding-system 'utf-8))

;; zsw eshell clear command setting
(defun eshell/clear ()
  "clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))

(global-linum-mode 1)

   (add-to-list 'load-path
                "/home/wegatron/.emacs.d/elpa/yasnippet-20150212.240/")
   (require 'yasnippet)
   (yas-global-mode 1)

(add-hook 'dired-mode-hook (lambda () (local-set-key (kbd "M-p") 'dired-up-directory) ))
(global-set-key (kbd "C-SPC") nil)
(global-set-key [f12] 'compile)

(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(global-set-key (kbd "C-c =") 'hs-hide-block)
(global-set-key (kbd "C-c -") 'hs-show-block)
(global-set-key (kbd "C-c s") 'hs-show-all)
(global-set-key (kbd "C-c h") 'hs-hide-all)

(provide 'init-locales)
;;; init-locales.el ends here
