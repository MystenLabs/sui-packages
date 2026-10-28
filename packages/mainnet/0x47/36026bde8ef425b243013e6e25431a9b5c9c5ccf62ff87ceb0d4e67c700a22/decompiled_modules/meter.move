module 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::meter {
    struct Meter has copy, drop, store {
        day: u64,
        used: u64,
    }

    public(friend) fun charge(arg0: &mut Meter, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 86400000;
        if (v0 > arg0.day) {
            arg0.day = v0;
            arg0.used = 0;
        };
        assert!((arg0.used as u128) + (arg1 as u128) <= (arg2 as u128), 0);
        arg0.used = arg0.used + arg1;
    }

    public fun new(arg0: &0x2::clock::Clock) : Meter {
        Meter{
            day  : 0x2::clock::timestamp_ms(arg0) / 86400000,
            used : 0,
        }
    }

    public(friend) fun refund(arg0: &mut Meter, arg1: u64) {
        let v0 = if (arg1 > arg0.used) {
            0
        } else {
            arg0.used - arg1
        };
        arg0.used = v0;
    }

    public fun used_today(arg0: &Meter, arg1: &0x2::clock::Clock) : u64 {
        if (0x2::clock::timestamp_ms(arg1) / 86400000 > arg0.day) {
            0
        } else {
            arg0.used
        }
    }

    // decompiled from Move bytecode v7
}

