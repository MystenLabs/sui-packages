module 0xfe217b1ab4e8299d7171172bc40c048823f37fc8f73cb813d46d6acaebe0a2a5::contador {
    struct Counter has drop {
        current: u64,
        target: u64,
    }

    fun assign(arg0: u64) : Counter {
        Counter{
            current : 0,
            target  : arg0,
        }
    }

    fun increment(arg0: &mut Counter) {
        assert!(arg0.current < arg0.target, 1);
        arg0.current = arg0.current + 1;
    }

    fun play(arg0: &mut Counter) {
        while (!(arg0.current == arg0.target)) {
            0x1::debug::print<u64>(&arg0.current);
            increment(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

