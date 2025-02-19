;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! all-the-icons)

(unpin! org-roam)
(package! org-roam-ui)

(package! org-excalidraw
  :recipe (:host github :repo "simplecottage/org-excalidraw")
)
