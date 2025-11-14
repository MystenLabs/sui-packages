module 0x388750ccc5bb5b792fa986b296f4cc86194e724d99e4a112d3687ff2e3249453::contador {
    struct Counter has drop {
        current: u64,
        target: u64,
    }

    fun get_current(arg0: &Counter) : u64 {
        0x1::debug::print<u64>(&arg0.current);
        arg0.current
    }

    fun increment(arg0: &mut Counter) {
        assert!(arg0.current < arg0.target, 13906834247357825025);
        arg0.current = arg0.current + 1;
    }

    fun is_completed(arg0: &Counter) : bool {
        arg0.current == arg0.target
    }

    fun new(arg0: u64) : Counter {
        Counter{
            current : 0,
            target  : arg0,
        }
    }

    fun play_counter(arg0: &mut Counter) {
        while (!is_completed(arg0)) {
            get_current(arg0);
            increment(arg0);
        };
        reset(arg0);
    }

    fun reset(arg0: &mut Counter) {
        arg0.current = 0;
    }

    // decompiled from Move bytecode v6
}

