module 0x8304bdb88c75ad7f9108a1ace7887548efe13374cc6c26ecba5ac93b868bb348::contador {
    struct Counter has drop {
        current: u64,
        target: u64,
    }

    fun getCurrent(arg0: &Counter) : u64 {
        0x1::debug::print<u64>(&arg0.current);
        arg0.current
    }

    fun increment(arg0: &mut Counter) {
        assert!(arg0.current < arg0.target, 13906834247357825025);
        arg0.current = arg0.current + 1;
    }

    fun isCompleted(arg0: &Counter) : bool {
        arg0.current == arg0.target
    }

    fun new(arg0: u64) : Counter {
        Counter{
            current : 0,
            target  : arg0,
        }
    }

    fun playCounter(arg0: &mut Counter) {
        while (!isCompleted(arg0)) {
            getCurrent(arg0);
            increment(arg0);
        };
        reset(arg0);
    }

    fun reset(arg0: &mut Counter) {
        arg0.current = 0;
    }

    // decompiled from Move bytecode v6
}

