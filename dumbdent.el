;;; dumbdent.el --- A pretty dumb way of indenting
;;;
;;; Copyright © 2013 Evan Bender
;;;
;;; Code:
(defun dumbdent (num)
  "Stick some spaces at the head of the line.
NUM is the number of spaces."

  (insert-char ?\s num))


(defun dumbdedent (num)
  "Chop some spaces off the head of the line.
NUM is the number of spaces."

  (let ((spaces num))
    (while (and (> spaces 0)
                (eq (char-after) ?\s))
      (delete-forward-char 1)
      (setq spaces (1- spaces)))))


(defun dumbdent-this-line ()
  "Do dumbdent to the current line."

  (interactive)
  (let ((pos (point))
        (num (default-value 'tab-width)))
    (beginning-of-line)
    (dumbdent num)
    (goto-char (+ pos num))))


(defun dumbdedent-this-line ()
  "Do dumbdedent to the current line."

  (interactive)
  (let ((pos (point))
         (num (default-value 'tab-width)))
    (beginning-of-line)
    (dumbdedent num)
        (goto-char (- pos num))))


(defun dumbdent-region (here end)
  "Do dumbdent to each line in the region.
HERE is somewhere on the first line to modify.
END is somewhere on the last line to modify."

  (interactive)
  (let ((end (region-end)))
    (while (< (point) end)
      (beginning-of-line)
      (dumbdent (default-value 'tab-width))
      (forward-line))))


;; (defun dumbdedent-region (here end)
;;   (interactive)
;;   (while (< (point) (region-end))
;;     (beginning-of-line)
;;     (dumbdedent (default-value 'tab-width))
;;     (forward-line)))

;; todo: generalize this line-wise function


(defun dumbdent-line-or-region ()
  "Do dumbdent-line or dumbdent-region, depending."

  (interactive)
  (if (use-region-p)
      (dumbdent-region (point) (region-end))
    (dumbdent-this-line)))


;; (very-evil-map [C-tab] 'dumbdent-this-line)
;; (very-evil-map [S-tab] 'dumbdedent-this-line)

(provide 'dumbdent)
;;; dumbdent.el ends here
