;;; lang/prog ---  -*- lexical-binding: t; -*-

;;; Commentary:

;; Shared configuration for all major modes extending `prog-mode'.
;;; Code:

(use-package prog-mode
  :ensure nil
  :preface
  (defun prog-mode-setup-display ()
    "Configure display settings for `prog-mode'."
    (setq-local show-trailing-whitespace t))
  (defun prog-mode-after-save ()
    "Post-save hook for `prog-mode'."
    (add-hook 'after-save-hook #'delete-trailing-whitespace nil t))
  :hook
  (prog-mode-hook . prog-mode-setup-display)
  (prog-mode-hook . prog-mode-after-save)
  (prog-mode-hook . electric-pair-mode))

;; Instead of using `show-parens-mode', we opt to use the more powerful `highlight-parentheses-mode'.
(use-package highlight-parentheses
  :config
  ;; We want to disable `show-paren-mode' to avoid double highlighting.
  (show-paren-mode -1)
  :diminish highlight-parentheses-mode
  :hook (prog-mode . highlight-parentheses-mode)
  :custom
  (highlight-parentheses-colors nil "We prefer to highlight parens using faces.")
  (highlight-parentheses-background-colors nil "We prefer to highlight parens using faces.")
  (highlight-parentheses-attributes
   '((:inherit show-paren-match))
   "Use the `show-paren-match' face to highlight the first pair of matching parentheses."))

(provide 'lang/prog)
;;; prog.el ends here
