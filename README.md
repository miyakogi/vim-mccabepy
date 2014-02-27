vim-mccabepy
============

This is a vim plugin to execute McCabe complexity check (mccabe.py) and reports the results in location-list window.

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

Open \*.py file and execute `:MccabePy`.

Configuration
-------------

### Minimum complexity

Default complexity of threshold to be reported is 10. To change this value, set `b:mccabepy_min_complexity` or `g:mccabepy_min_complexity`. If buffer local variable `b:mccabepy_min_complexity` exists, `g:mccabepy_min_complexity` is ignored.

### Reporting results

By default, results will be reported in the location-list window. If location-list window is not opened, it will be automatically opened. This action can be changed by using `g:mccabepy_loc_open_cmd` option. For example, if you are [Unite](https://github.com/Shougo/unite.vim) user and you want to use `Unite location-list` window, add the following lines in your vimrc. Then, the results will be reported in Unite window.

	let g:mccabepy_loc_open_cmd = 'Unite location-list -no-quit -buffer-name=mccabepy'

##### Close result window automatically

If there were nothing to be reported, no window will appear. If location-list window is opened, it will be closed automatically. To change this behaviour, use `g:mccabepy_loc_close_cmd`.

Example 1) Do not close location-list window.

	let g:mccabepy_loc_close_cmd = ''

Example 2) To close `Unite location-list` window if there are nothing to be reported.

	let g:mccabepy_loc_close_cmd = 'UniteClose mccabepy'
