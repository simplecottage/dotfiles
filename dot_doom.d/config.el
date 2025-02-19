;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq +doom-dashboard-ascii-banner-fn nil)

(add-hook 'after-init-hook (lambda ()
  (solaire-global-mode -1)
  (setq solaire-mode-in-minibuffer nil)
))

(add-hook 'org-mode-hook (lambda () (solaire-mode -1)))
(add-hook 'dired-mode-hook (lambda () (solaire-mode -1)))

(setq display-line-numbers-type 'relative)

(setq org-directory "~/org/")

(setq doom-font (font-spec :family "SF Mono" :size 16)
      doom-variable-pitch-font (font-spec :family "Sans" :size 16)
      doom-symbol-font (font-spec :family "Noto Color Emoji" :size 16)
      doom-theme 'doom-material-dark)

(custom-theme-set-faces! 'doom-material-dark
  '(default :background "#181818"))

(remove-hook 'dired-mode-hook #'dired-omit-mode)


;; ORG-ROAM
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/Documents/notas/"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol)
)

(use-package! websocket
    :after org-roam
)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t)
)

(require 'org)

;; ORG-EXCALIDRAW
(require 'org-excalidraw)
(use-package org-excalidraw
  :config
  (setq org-excalidraw-directory "~/Documents/notas/excalidrawings" )
)
(after! org
  (org-excalidraw-initialize))

(defface org-excalidraw-link-face
  '((t (:inherit org-link :underline nil)))
  "Face for Excalidraw links without underline."
  :group 'org-faces)

(org-link-set-parameters "excalidraw"
                         :face 'org-excalidraw-link-face)


(add-hook 'org-mode-hook 'org-display-inline-images)

(defun iimage-resize ()
  (let ((max-width 750))
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward "\\[\\[excalidraw:\\(.*\\.\\(?:png\\|jpg\\|jpeg\\|svg\\)\\)\\]" nil t)
        (let* ((file (match-string 1))
               (image (create-image file))
               (width (car (image-size image t)))
               (height (cdr (image-size image t)))
               (scale-factor (/ (float max-width) (float width)))
               (new-width max-width)
               (new-height (* height scale-factor)))
          (put-text-property
           (match-beginning 0) (match-end 0)
           'display (create-image file nil nil :width new-width :height new-height)))))))

(add-hook 'org-mode-hook #'iimage-resize)
