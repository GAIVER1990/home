;; Font settings
(set-frame-font "Hack 18")
;; The full name of the user logged in
;; Full mailing address of user
(setq-default user-full-name   "crandel"
              user-mail-adress "cradlemann@gmail.com")

;; Set zsh as default shell
(setq-default shell-file-name           "/bin/zsh")
;;      explicit-shell-file-name  "/bin/zsh")

;; Inhibit startup/splash screen
(setq-default inhibit-startup-screen t)

;; Imenu
(require 'imenu)
(setq imenu-auto-rescan      t
      imenu-use-popup-menu   nil)
(semantic-mode 1)
(setq-default semantic-which-function-use-color t)

;; SavePlace
(save-place-mode 1)
(setq-default save-place-file                       "~/.emacs.d/saved-places"
              save-place-forget-unreadable-files    t)

;; Electric-modes settings
(electric-pair-mode     -1)
(electric-indent-mode   -1)
;; Delete selection
(delete-selection-mode t)

;; Emacs GUI settings
(when (display-graphic-p)
  (tool-bar-mode    -1)
  (scroll-bar-mode  -1)
  ;; Fringe settings
  (fringe-mode '(8 . 0))
  (setq-default indicate-buffer-boundaries 'left)
  ;; Cursor
  (setq-default cursor-type 'bar)
  (set-cursor-color "#BE81F7")
  (blink-cursor-mode 1)
)

(tooltip-mode     -1)
(menu-bar-mode    -1)
(setq-default use-dialog-box        nil
              ring-bell-function    'ignore)

;; Display the name of the current buffer in the title bar
(setq frame-title-format "%b")

;; Enable backup/autosave files
;; Save all tempfiles in $TMPDIR/emacs$UID/
(defconst emacs-tmp-dir (expand-file-name (format "emacs%d/" (user-uid)) temporary-file-directory))
(setq
      auto-save-default              t
      auto-save-interval             0
      auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t))
      auto-save-list-file-name       nil
      auto-save-list-file-prefix     emacs-tmp-dir
      auto-save-timeout              3
      backup-directory-alist         `((".*" . ,emacs-tmp-dir))
      backup-inhibited               t
      create-lockfiles               nil ;; Disable lockfiles .#filename
      delete-old-versions            t   ;; Don't ask to delete excess backup versions.
      make-backup-files              t
      version-control                t   ;; Use version numbers for backups.
      vc-make-backup-files           t   ;; Emacs never backs up versioned files
      kept-new-versions              5   ;; Number of newest versions to keep.
      kept-old-versions              0   ;; Number of oldest versions to keep.
)

;; Coding-system settings
(set-language-environment               'UTF-8)
(setq buffer-file-coding-system         'utf-8
      file-name-coding-system           'utf-8)
(setq-default coding-system-for-read    'utf-8)
(set-selection-coding-system            'utf-8)
(set-keyboard-coding-system             'utf-8-unix)
(set-terminal-coding-system             'utf-8)
(prefer-coding-system                   'utf-8)

(setq-default display-line-numbers t)
(column-number-mode 1)

;; Display file size/time in mode-line
(setq display-time-24hr-format  t)
(display-time-mode              t)
(size-indication-mode           t)
(defun add-mode-line-dirtrack ()
  (add-to-list 'mode-line-buffer-identification
              '(:propertize (" " default-directory " ") face dired-directory)))
(add-hook 'shell-mode-hook 'add-mode-line-dirtrack)

;; Indent settings
(setq-default indent-tabs-mode      nil
              tab-width             4
              tab-always-indent     nil
              c-basic-offset        2
              sh-basic-offset       2
              sh-indentation        2
              scala-basic-offset    2
              java-basic-offset     2
              standart-indent       2
              lisp-body-indent      2
              rust-indent-offset    4
              js-indent-level       2
              indent-line-function  'insert-tab)

;; Scrolling settings
(setq scroll-step             1
      scroll-margin           10
      scroll-conservatively   10000)

;; Short messages
(defalias 'yes-or-no-p 'y-or-n-p)

;; Clipboard settings
(setq select-enable-clipboard             t
      save-interprogram-paste-before-kill t
      wl-copy-process                     nil)
(defun wl-copy (text)
  (setq wl-copy-process (make-process :name "wl-copy"
                                      :buffer nil
                                      :command '("wl-copy" "-f" "-n")
                                      :connection-type 'pipe))
  (process-send-string wl-copy-process text)
  (process-send-eof wl-copy-process))
(defun wl-paste ()
  (if (and wl-copy-process (process-live-p wl-copy-process))
      nil ; should return nil if we're the current paste owner
    (shell-command-to-string "wl-paste -n | tr -d \r")))
(setq interprogram-cut-function 'wl-copy)
(setq interprogram-paste-function 'wl-paste)
;; End sway clipboard settings

(setq next-line-add-newlines nil)

;; Highlight search resalts
(setq search-highlight            t
      query-replace-highlight     t
      auto-window-vscroll         nil
      bidi-display-reordering     nil)

;; Whitespace
(require 'whitespace)
(autoload 'global-whitespace-mode   "whitespace" "Toggle whitespace visualization." t)
(setq whitespace-style
      '(face trailing spaces lines-tail empty indentation::tab indentation::space tabs newline space-mark tab-mark newline-mark))
(global-whitespace-mode 1)
(setq whitespace-global-modes '(not magit-diff-mode))
(setq whitespace-display-mappings
      ;; all numbers are Unicode codepoint in decimal. ⁖ (insert-char 182 1)
      '(
        (space-mark 32 [183] [46]) ; 32 SPACE 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
        (newline-mark 10 [8617 10]) ; 10 LINE FEED
        (lines-tail 10 [8617 10]) ; 10 LINE FEED
        (tab-mark 9 [8594 9] [183 9]) ; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「▷」
        )
      whitespace-line-column 130)

(setq split-height-threshold  nil
      split-width-threshold   0)

(if (equal nil (equal major-mode 'org-mode))
    (windmove-default-keybindings 'meta))

(recentf-mode 1)
(setq recentf-max-menu-items      150
      recentf-max-saved-items     1550)

;; Show paren
(setq show-paren-delay 0
      show-paren-style 'expression)
(show-paren-mode 2)

(setq ns-pop-up-frames          nil
      ad-redefinition-action    'accept)

(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode 1))

;; Russian
(cl-loop
 for from across "йцукенгшщзхїфівапролджєячсмитьбюЙЦУКЕНГШЩЗХЇФІВАПРОЛДЖ\ЄЯЧСМИТЬБЮ№"
 for to   across "qwertyuiop[]asdfghjkl;'zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>#"
 do
 (eval `(define-key local-function-key-map
          (kbd ,(concat "C-"
                        (string from)))
          (kbd ,(concat "C-"
                        (string to)))))
 (eval `(define-key local-function-key-map
          (kbd ,(concat "M-"
                        (string from)))
          (kbd ,(concat "M-"
                        (string to)))))
 (eval `(define-key local-function-key-map
          (kbd ,(string from))
          (kbd ,(string to)))))

(defadvice read-passwd (around my-read-passwd act)
  (let ((local-function-key-map nil))
    ad-do-it))

(setq max-mini-window-height      0.5
      compilation-always-kill     t
      compilation-disable-input   t
      compilation-window-height   10
      )


(setq dired-listing-switches "-ahlF --time-style=long-iso --group-directories-first")

(provide 'scratch_my)
