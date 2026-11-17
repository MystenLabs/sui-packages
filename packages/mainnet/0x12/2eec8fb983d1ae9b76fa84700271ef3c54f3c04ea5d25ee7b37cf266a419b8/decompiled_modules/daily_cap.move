module 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::daily_cap {
    struct DailyCap<phantom T0> has drop, store {
        limit: u64,
        meter: 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::meter::Meter,
    }

    public(friend) fun charge<T0>(arg0: &mut DailyCap<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!((0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::meter::used_today(&arg0.meter, arg2) as u128) + (arg1 as u128) <= (arg0.limit as u128), 0);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::meter::charge(&mut arg0.meter, arg1, arg0.limit, arg2);
    }

    public fun limit<T0>(arg0: &DailyCap<T0>) : u64 {
        arg0.limit
    }

    public fun new<T0>(arg0: u64, arg1: &0x2::clock::Clock) : DailyCap<T0> {
        assert!(arg0 > 0, 1);
        DailyCap<T0>{
            limit : arg0,
            meter : 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::meter::new(arg1),
        }
    }

    public(friend) fun refund<T0>(arg0: &mut DailyCap<T0>, arg1: u64) {
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::meter::refund(&mut arg0.meter, arg1);
    }

    public fun set_limit<T0>(arg0: &mut DailyCap<T0>, arg1: u64) {
        assert!(arg1 > 0, 1);
        arg0.limit = arg1;
    }

    public fun used_today<T0>(arg0: &DailyCap<T0>, arg1: &0x2::clock::Clock) : u64 {
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::meter::used_today(&arg0.meter, arg1)
    }

    // decompiled from Move bytecode v7
}

