;;; dumbdent.el --- A pretty dumb way of indenting
;;;
;;; Copyright © 2013 Evan Bender
;;;
;;; Code:
(defun dumbdent-this-line ()
  "Indent current line."

  (interactive)
  (let ((num (default-value 'tab-width)))
    (indent-rigidly (line-beginning-position) (line-end-position) num)
    (back-to-indentation)))


(defun dumbdedent-this-line ()
  "Dedent the current line."

  (interactive)
  (let ((num (default-value 'tab-width)))
    (indent-rigidly (line-beginning-position) (line-end-position) (- num))
    (back-to-indentation)))


(defun dumbdent-region ()
  "Indent each line in the region.
   So far the mark-point behavior is a little odd: we lose highlight
   when selecting in one direction, but not the other. wtf."

  (interactive)
  (if (< (mark) (point))
      (exchange-point-and-mark))
  (save-excursion
    (beginning-of-line)
    (indent-rigidly (point) (mark) (default-value 'tab-width))
    ;; this is goofy and I am clearly missing something about how transient-mark-mode works
    (exchange-point-and-mark)
    ;; would rather something simple and to the point *NO PUN INTENDED* like
    ;; (activate-mark)
    ))


(defun dumbdedent-region ()
  "Dedent each line in the region."

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


;; (very-evil-map [C-tab] 'dumbdent-line-or-region)
;; (very-evil-map [S-tab] 'dumbdedent-line-or-region)

(provide 'dumbdent)
;;; dumbdent.el ends here
