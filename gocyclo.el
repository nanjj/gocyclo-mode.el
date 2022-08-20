;;; gocyclo.el --- Run gocyclo

;; Author: JUN JIE NAN <nanjunjie@gmail.com>
;; URL: https://github.com/nanjj/gocyclo.el
;; Keywords: languages, go, cyclo

;;; Commentary:

;;; Code:

(require 'compile)

(defun gocyclo-compilation-hook (p)
  "Add gocyclo compilation hooks"
  ;; 19 cluster (*Cluster).HeartbeatNodeHook heartbeat.go:363:1
  (set (make-local-variable 'compilation-error-regexp-alist-alist)
       '((go-cyclo . ("^[[:digit:]]+[[:blank:]][[:alnum:]]+[[:blank:]][[:alnum:]()*.]+[[:blank:]]\\([[:alnum:]]+\\.go\\):\\([[:digit:]]+\\):.*$" 1 2))))
  (set (make-local-variable 'compilation-error-regexp-alist)
       '(go-cyclo)))

(defun gocyclo()
  "Run gocyclo on current file"
  (interactive)
  (add-hook 'compilation-start-hook 'gocyclo-compilation-hook)
  (compilation-start
   (s-concat
    "gocyclo" " "
    (file-relative-name (buffer-file-name))))
  (remove-hook 'compilation-start-hook 'gocyclo-compilation-hook))

(provide 'gocyclo)
