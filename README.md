# Timecop-PHP
Time testing php library inspired by [ruby timecop gem](https://github.com/travisjeffery/timecop).

Timecop-PHP provides wrappers around date/time functions:

- time (Timecop::time())
- date (Timecop::date())
- getdate (Timecop::getdate())
- gmdate (Timecop::gmdate())
- gmmktime (Timecop::gmmktime())
- gmstrftime (Timecop::gmstrftime())
- idate (Timecop::idate())
- localtime (Timecop::localtime())
- mktime (Timecop::mktime())
- strftime (Timecop::strftime())
- strptime (Timecop::strptime())
- strtotime (Timecop::strtotime())

You can override built-in functions in cases where it's not possible to replace
parts of code using PHP's built-in functions like time() or date() with Timecop wrappers.
To do so `runkit` pecl extension (or runkit7/runkit7 fork) must be installed and working.
See installation section for more details.

## Usage
    // override internal PHP functions
    Timecop::warpTime();

    // time travel
    $presentTime = time();
    Timecop::travel(time() - 3600); // one hour back

    $presentTime > time(); // TRUE

    Timecop::travel(time() + 7200); // one hour forward
    $presentTime < time(); // TRUE

    // freeze time
    Timecop::freeze();
    $frozenTime = time();
    sleep(2);

    $frozenTime == time(); // TRUE

    // restore time - unfreezes time and returns to present
    Timecop::restore();

    $frozenTime == time(); // FALSE
    $frozenTime > time(); // TRUE

    // restore original PHP functionality
    Timecop::unwarpTime();

## Installation and Configuration

For php >= 7.0, a different fork must be used. (the runkit pecl does not support php 5)

    $ git clone https://github.com/runkit7/runkit7
    $ cd ./runkit
    $ phpize
    $ ./configure && make
    $ make test
    $ make install

For php 5.x (TODO: Restore `$is_dst` param)

    $ git clone https://github.com/zenovich/runkit
    $ cd ./runkit
    $ phpize
    $ ./configure && make
    $ make test
    $ make install

You need to enable runkit extension and override flag in `php.ini`:

    extension=runkit.so
    runkit.internal_override = 1

## Examples

See [tests/ReadmeTest.php](tests/ReadmeTest.php)
