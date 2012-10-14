(add-to-list 'load-path "~/.emacs.d/modules/")

; Keep backupts in seperate folder
; http://emacswiki.org/emacs/BackupDirectory
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

; Force .h files as c++ mode
; http://www.emacswiki.org/emacs/CPlusPlusMode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

; Override namespace indent
; http://stackoverflow.com/questions/2619853/emacs-override-indentation
(c-set-offset 'innamespace 0)

; Set code style
; http://www.emacswiki.org/emacs/IndentingC#toc2
(setq c-default-style "bsd"
          c-basic-offset 2)

; Show trailing whitespaces
; http://trey-jackson.blogspot.dk/2008/03/emacs-tip-12-show-trailing-whitespace.html
(setq-default show-trailing-whitespace t)

; More informative names for files with the same name
; http://trey-jackson.blogspot.dk/2008/01/emacs-tip-11-uniquify.html
(require 'uniquify)
    (setq uniquify-buffer-name-style 'reverse)
    (setq uniquify-separator "/")
    (setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
    (setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

; Fill Column Inducator
; http://www.emacswiki.org/emacs/FillColumnIndicator
(require 'fill-column-indicator)
;(add-hook 'c++-mode-hook 'fci-mode)
(add-hook 'c++-mode-hook 'column-number-mode)
(setq fci-rule-width 1)
(setq fci-rule-color "darkblue")
(setq fci-rule-use-dashes 1)
(setq default-fill-column 100)

;
(setq whitespace-style '(lines))
(setq whitespace-line-column 78)
(global-whitespace-mode 1)

;http://emacs-fu.blogspot.dk/2008/12/highlighting-todo-fixme-and-friends.html
;
(add-hook 'c-mode-common-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("\\<\\(FIXME\\|todo\\|BUG\\):" 1 font-lock-warning-face t)))))

; compile-on-save-mode
; http://rtime.felk.cvut.cz/~sojka/blog/compile-on-save/
(defun compile-on-save-start ()
  (let ((buffer (compilation-find-buffer)))
    (unless (get-buffer-process buffer)
      (recompile))))

(define-minor-mode compile-on-save-mode
  "Minor mode to automatically call `recompile' whenever the
current buffer is saved. When there is ongoing compilation,
nothing happens."
  :lighter " CoS"
    (if compile-on-save-mode
    (progn  (make-local-variable 'after-save-hook)
        (add-hook 'after-save-hook 'compile-on-save-start nil t))
      (kill-local-variable 'after-save-hook)))

; Toggle hpp/cpp file with darc & catkin
; http://superuser.com/questions/255510/how-to-toggle-between-cpp-and-hpp-that-are-not-in-the-same-directory
(setq cc-other-file-alist
      '(("\\.cpp" (".hpp"))
        ("\\.hpp" (".cpp"))))

(setq ff-search-directories
      '("." "../../src" "../include/darc"))

;;; Bind the toggle function to a global key
(global-set-key "\M-t" 'ff-find-other-file)