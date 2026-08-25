module 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::drip {
    struct Drip<phantom T0> has store {
        locked: 0x2::balance::Balance<T0>,
        rate_per_second: u64,
        last_drip_ts_sec: u64,
    }

    public fun destroy_empty<T0>(arg0: Drip<T0>) {
        let Drip {
            locked           : v0,
            rate_per_second  : _,
            last_drip_ts_sec : _,
        } = arg0;
        let v3 = v0;
        assert!(0x2::balance::value<T0>(&v3) == 0, 0);
        0x2::balance::destroy_zero<T0>(v3);
    }

    public fun withdraw_all<T0>(arg0: &mut Drip<T0>, arg1: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        let v0 = drip<T0>(arg0, arg1);
        arg0.rate_per_second = 0;
        (v0, 0x2::balance::withdraw_all<T0>(&mut arg0.locked))
    }

    public fun drip<T0>(arg0: &mut Drip<T0>, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (v0 <= arg0.last_drip_ts_sec || arg0.rate_per_second == 0) {
            return 0x2::balance::zero<T0>()
        };
        let v1 = 0x2::balance::value<T0>(&arg0.locked);
        let v2 = ((v0 - arg0.last_drip_ts_sec) as u128) * (arg0.rate_per_second as u128);
        let v3 = if (v2 < (v1 as u128)) {
            (v2 as u64)
        } else {
            v1
        };
        arg0.last_drip_ts_sec = v0;
        if (v3 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(&mut arg0.locked, v3)
        }
    }

    public fun destroy<T0>(arg0: Drip<T0>) : 0x2::balance::Balance<T0> {
        let Drip {
            locked           : v0,
            rate_per_second  : _,
            last_drip_ts_sec : _,
        } = arg0;
        v0
    }

    public fun estimated_end_ts_sec<T0>(arg0: &Drip<T0>) : u64 {
        arg0.last_drip_ts_sec + remaining_seconds<T0>(arg0)
    }

    public fun last_drip_ts_sec<T0>(arg0: &Drip<T0>) : u64 {
        arg0.last_drip_ts_sec
    }

    public fun locked_balance<T0>(arg0: &Drip<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.locked)
    }

    public fun new<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64) : Drip<T0> {
        Drip<T0>{
            locked           : arg0,
            rate_per_second  : arg1,
            last_drip_ts_sec : arg2,
        }
    }

    public fun rate_per_second<T0>(arg0: &Drip<T0>) : u64 {
        arg0.rate_per_second
    }

    public fun remaining_seconds<T0>(arg0: &Drip<T0>) : u64 {
        if (arg0.rate_per_second == 0) {
            return 0
        };
        0x2::balance::value<T0>(&arg0.locked) / arg0.rate_per_second
    }

    public fun set_rate<T0>(arg0: &mut Drip<T0>, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = drip<T0>(arg0, arg2);
        if (arg0.rate_per_second == 0) {
            let v1 = 0x2::clock::timestamp_ms(arg2) / 1000;
            if (v1 > arg0.last_drip_ts_sec) {
                arg0.last_drip_ts_sec = v1;
            };
        };
        arg0.rate_per_second = arg1;
        v0
    }

    public fun top_up<T0>(arg0: &mut Drip<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = drip<T0>(arg0, arg2);
        0x2::balance::join<T0>(&mut arg0.locked, arg1);
        v0
    }

    // decompiled from Move bytecode v7
}

