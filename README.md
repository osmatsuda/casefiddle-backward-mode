# casefiddle-backward-mode

This is a minor mode converting to uppercase, lowercase and capitalize some words from point to backward, but don't move.

Same as `C-u -N M-u/M-l/M-c`, but more intuitively.

## Installation

Copy the file `casefiddle-backward-mode.el` to a directory in your `load-path`.

Then you can setup like this:

```elisp
(autoload 'casefiddle-backward-mode "casefiddle-backward-mode" nil t)
```

## Usage

First enter this minor mode, then enter M-u/M-l/M-c *N* times, finally casefiddled backward *N* words from point.

When you move current point, you can exit this minor mode.

### Example

Setup like this:

```elisp
(define-key global-map "\C-c\M-u" 'casefiddle-backward-mode)
(define-key global-map "\C-c\M-l" 'casefiddle-backward-mode)
(define-key global-map "\C-c\M-c" 'casefiddle-backward-mode)
```

In Any mode. -!- indicates the current point.:

```
#define assert_not_empty-!-
```

After `C-c M-u`:

```
----- Mode line -----
  (AnyMode <-Case)
----- Mode line -----
```

After `M-u M-u M-u`:

```
#define ASSERT_NOT_EMPTY-!-
```

When you move or enter any char, you can exit this minor mode.
