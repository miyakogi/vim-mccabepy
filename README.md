vim-mccabepy
============

This is a vim plugin to execute McCabe complexity check (mccabe.py) and reports the results in quickfix window.

Installation
------------

If you are using [NeoBundle](https://github.com/Shougo/neobundle.vim), add the following line in your vimrc.

```vim
NeoBundle 'miyakogi/vim-mccabepy'
```

Then reload vim and execute `:NeoBundleInstall`.

Before run this plugin, please install mccabe.py, by `pip install mccabe` or any other proper way. If you are going to use this plugin in virtual environment made by `virtualenv`, please install `mccabe.py` into the virtual environment.

Usage
-----

Open any python script file and execute `:MccabePy`.

Configuration
-------------

### Minimum complexity

Default threshold complexity to be reported is 10. To change this value, set `b:mccabepy_min_complexity` or `g:mccabepy_min_complexity`. If `b:mccabepy_min_complexity` exists, `g:mccabepy_min_complexity` is ignored.

### Reporting results

By default, results will be reported in quickfix window. If quickfix window is not opened, it will be automatically opened. This action can be changed by `g:mccabepy_qfix_command` option. For example, if you are [Unite](https://github.com/Shougo/unite.vim) user and you want to use `Unite quickfix` window, add the following lines in your vimrc.

	let g:mccabepy_qfix_command = 'Unite quickfix -no-quit -buffer-name=quickfix'

##### Close result window automatically

If there were nothing to be reported, no window will appear. To execute any command at this time, use `g:mccabepy_qfix_close_command`.

Example 1) To close quickfix window if there are any reports,

	let g:mccabepy_qfix_close_command = 'cclose'

Example 2) To close `Unite quickfix` window if there are any reports,

	let g:mccabepy_qfix_close_command = 'UniteClose qcuikfix'
