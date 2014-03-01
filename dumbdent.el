;;; dumbdent.el --- A pretty dumb way of indenting
;;;
;;; Copyright © 2013 Evan Bender
;;;
;;; Code:
(defun dumbdent (num)
  "Stick some spaces at the head of the line.
   NUM is the number of spaces to add."

  (insert-char ?\s num))


(defun dumbdedent (num)
  "Chop some spaces off the head of the line.
   NUM is the maximum number of spaces to remove."

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
    (back-to-indentation)))


(defun dumbdedent-this-line ()
  "Do dumbdedent to the current line."

  (interactive)
  (let ((pos (point))
        (num (default-value 'tab-width)))
    (beginning-of-line)
    (dumbdedent num)
    (back-to-indentation)))


(defun dumbdent-region ()
  "Do dumbdent to each line in the region.
   So far the mark-point behavior is a little odd."

  (interactive)
  (if (< (mark) (point))
      (exchange-point-and-mark))
  (save-excursion
    (beginning-of-line)
    (indent-rigidly (point) (mark) (default-value 'tab-width))
    ;; this is goofy and I am clearly missing something about how transient-mark-mode works
    (exchange-point-and-mark)
    ;;(exchange-point-and-mark)
    ;; would rather something simple and to the point *NO PUN INTENDED* like
    ;; (activate-mark)
    ))


(defun dumbdedent-region ()
  "Do dumbdedent to each line in the region."

  (interactive)
  (if (< (mark) (point))
      (exchange-point-and-mark))
  (save-excursion
    (beginning-of-line)
    (indent-rigidly (point) (mark) (- (default-value 'tab-width)))
    (exchange-point-and-mark)
    ))



(defun dumbdent-line-or-region ()
  "Do dumbdent-region if in transient mark mode and there is an active region,
   otherwise just dumbdent-line."

  (interactive)
  (if (use-region-p)
      (dumbdent-region)
    (dumbdent-this-line)))

(defun dumbdedent-line-or-region ()
  "Do dumbdedent-line or dumbdedent-region, depending."

  (interactive)
  (if (use-region-p)
      (dumbdedent-region)
    (dumbdedent-this-line)))


;; (very-evil-map [C-tab] 'dumbdent-this-line)
;; (very-evil-map [S-tab] 'dumbdedent-this-line)

(provide 'dumbdent)
;;; dumbdent.el ends here
