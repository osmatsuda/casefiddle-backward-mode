;;; casefiddle-backward-mode.el --- Casefiddle backward minor mode  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  osmatsuda

;; Author: osmatsuda <osmatsuda@gmail.com>
;; Keywords: wp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; https://github.com/osmatsuda/casefiddle-backward-mode

;;; Code:

(defvar casefiddle-backward--alist)

(defvar casefiddle-backward-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\M-u" 'casefiddle-backward--upcase)
    (define-key map "\M-l" 'casefiddle-backward--downcase)
    (define-key map "\M-c" 'casefiddle-backward--capitalize)
    map)
  "The keymap used when `casefiddle-backward-mode' is active.")

(define-minor-mode casefiddle-backward-mode
  "Toggle Casefiddle backward minor mode in the current buffer."
  :init-value nil
  :lighter " <-Case"
  :keymap casefiddle-backward-mode-map
  :group 'casefiddle-backward
  (if casefiddle-backward-mode
      (casefiddle-backward--enter)
    (casefiddle-backward--exit)))

(defun casefiddle-backward--enter ()
  "Initialization for `casefiddle-backward-mode'."
  (let ((c (let ((count 1))
	     (lambda (arg)
	       (unwind-protect
		   (if (not arg)
		       (* -1 count)
		     (if (= 0 arg)
			 (* -1 count)
		       (* -1 (setq count (abs arg)))))
		 (setq count (1+ count))))))
	(e (point)))
    (set (make-local-variable 'casefiddle-backward--alist)
	 (list (cons 'count c)
	       (cons 'enter e))))

  (add-hook 'post-command-hook 'casefiddle-backward--will-exit nil t))

(defun casefiddle-backward--will-exit ()
  (unless (= (cdr (assq 'enter casefiddle-backward--alist)) (point))
    (casefiddle-backward-mode -1)))

(defun casefiddle-backward--exit ()
  "Turn off `casefiddle-backward-mode'."
  (setq casefiddle-backward--alist nil)
  (remove-hook 'post-command-hook 'casefiddle-backward--will-exit t))

(defun casefiddle-backward--upcase (&optional arg)
  "Upcase words backward from point."
  (interactive "P")
  (if casefiddle-backward--alist
      (upcase-word (funcall (cdr (assq 'count
				       casefiddle-backward--alist))
			    arg))
    (upcase-word arg)))

(defun casefiddle-backward--downcase (&optional arg)
  "Downcase words backward from point."
  (interactive "P")
  (if casefiddle-backward--alist
      (downcase-word (funcall (cdr (assq 'count
					 casefiddle-backward--alist))
			      arg))
    (downcase-word arg)))

(defun casefiddle-backward--capitalize (&optional arg)
  "Capitalize words backward from point."
  (interactive "P")
  (if casefiddle-backward--alist
      (capitalize-word (funcall (cdr (assq 'count
					   casefiddle-backward--alist))
				arg))
    (capitalize-word arg)))

(provide 'casefiddle-backward-mode)
;;; casefiddle-backward-mode.el ends here
