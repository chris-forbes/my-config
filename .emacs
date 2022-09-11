(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (deeper-blue)))
 '(package-selected-packages
   (quote
    (phpunit nginx-mode multiple-cursors dockerfile-mode docker-compose-mode cpp-auto-include company-shell company-terraform company-ansible company-php company ansible-vault ansible-doc ansible terraform-mode use-package neotree))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;
;; Verify the use-package plugin is installed
;;

(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))
(require 'use-package)

;;
;; Make sure everything i need is installed
;;
(use-package neotree
  :ensure neotree)

(use-package hcl-mode
  :ensure hcl-mode)

(use-package terraform-mode
  :ensure terraform-mode)

(use-package ansible
  :ensure ansible)

(use-package ansible-doc
  :ensure ansible-doc)

(use-package ansible-vault
  :ensure ansible-vault)

(use-package company
  :ensure company)

(use-package company-php
  :ensure company-php)

(use-package company-ansible
  :ensure company-ansible)

(use-package company-terraform
  :ensure company-terraform)

(use-package company-shell
  :ensure company-shell)

(use-package cpp-auto-include
  :ensure cpp-auto-include)

(use-package docker-compose-mode
  :ensure docker-compose-mode)

(use-package dockerfile-mode
  :ensure dockerfile-mode)

(use-package multiple-cursors
  :ensure multiple-cursors)

(use-package nginx-mode
  :ensure nginx-mode)

(use-package php-mode
  :ensure php-mode)

(use-package phpunit
  :ensure phpunit)

(if (eq system-type 'darwin)
    (use-package osx-clipboard
      :ensure osx-clipboard))


;;
;; Enable company mode in all buffers
;;
(add-hook 'after-init-hook 'global-company-mode)


;;
;; Misc custom functions
;;
(defun indent-whole-file ()
  "Indent the whole file by marking the buffer and running indent"
  (interactive)
  (call-interactively 'mark-whole-buffer)
  (call-interactively 'indent-region))

(defun switch-to-shell ()
  "Assuming there is a *shell* running swap to it automatically in the current buffer window"
  (interactive)
  (call-interactively 'shell))

(defun new-module ()
  "Creates a new terraform module in the currently open in ${PROJECT_BASE}/Modules"
  (interactive)
  (let (module-path module-name)
    (setq module-path(read-directory-name "Module directory:"))
    (setq module-name(read-string "Name of module:"))
    (setq full-path(concat module-path module-name "/"))
    (message "Creating Module %s" full-path)
    (make-directory full-path)
    (write-region "" nil (concat full-path "main.tf"))
    (write-region "" nil (concat full-path "variable.tf"))
    (write-region "" nil (concat full-path "output.tf"))
    ))

(defun show-whitespace-and-tabs ()
  (interactive)
  (whitespace-mode)
  )

(defun tabs-to-spaces ()
  (interactive)
  (untabify (point-min)(point-max)))

(defun spaces-to-tabs ()
  (interactive)
  (tabify (point-min)(point-max)))


;; 
;; Custom key bindings
;;
(global-set-key [f8] 'neotree-toggle)
(global-set-key [f7] 'indent-whole-file)
(global-set-key [f6] 'switch-to-shell)
(global-set-key [C-f6] 'show-whitespace-and-tabs)
(global-set-key [f9] 'mc/edit-lines)

;;
;; My custom menu because why not
;;
(define-key-after
  global-map
  [menu-bar furby]
  (cons "Furby-Utils" (make-sparse-keymap "Furby Utils"))
  'tools)

;;
;; Create submenu items in the furby-utils menu
;;
(define-key-after
  global-map
  [menu-bar furby terraform]
  (cons "Terraform" (make-sparse-keymap "Terraform"))
  'tools)

(define-key-after
  global-map
  [menu-bar furby utils]
  (cons "Utils" (make-sparse-keymap "Utils"))
  'tools)

(define-key
  global-map
  [menu-bar furby fi]
  '("Indent Whole file" . indent-whole-file))

(define-key
  global-map
  [menu-bar furby ss]
  '("Switch to shell" . switch-to-shell))

(define-key
  global-map
  [menu-bar furby ws]
  '("Enable whitespace mode" . show-whitespace-and-tabs))

(define-key
  global-map
  [menu-bar furby terraform new-module]
  '("New Terraform Module" . new-module))

(define-key
  global-map
  [menu-bar furby utils tts]
  '("Tabs to spaces" . tabs-to-spaces))

(define-key
  global-map
  [menu-bar furby utils stt]
  '("Spaces to tabs" . spaces-to-tabs))


