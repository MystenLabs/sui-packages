module 0x64cc14613822a5819fc50ad1d28202aab79bd69bec5159d4dde1f096b7d548a3::contador {
    struct Counter has drop {
        current: u64,
        target: u64,
    }

    fun get_current(arg0: &Counter) : u64 {
        0x1::debug::print<u64>(&arg0.current);
        arg0.current
    }

    fun increment(arg0: &mut Counter) {
        assert!(arg0.current < arg0.target, 13906834268832661505);
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

