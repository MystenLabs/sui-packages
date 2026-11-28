module 0x2f3bfde0b46644deb1ba583b60c054965d485482e25ab3465526f6165e145f9b::cpmm {
    public fun get_amount_in(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 1);
        assert!(arg3 < 10000, 2);
        assert!(arg0 < arg2, 3);
        let v0 = (arg1 as u256) * (arg0 as u256) * 10000;
        let v1 = ((arg2 - arg0) as u256) * (10000 - (arg3 as u256));
        let v2 = if (v0 % v1 != 0) {
            v0 / v1 + 1
        } else {
            v0 / v1
        };
        assert!(v2 <= 18446744073709551615, 4);
        (v2 as u64)
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 1);
        assert!(arg3 < 10000, 2);
        let v0 = (arg0 as u256) * (10000 - (arg3 as u256));
        ((v0 * (arg2 as u256) / ((arg1 as u256) * 10000 + v0)) as u64)
    }

    public fun quote(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 1);
        let v0 = (arg0 as u256) * (arg2 as u256) / (arg1 as u256);
        assert!(v0 <= 18446744073709551615, 4);
        (v0 as u64)
    }

    // decompiled from Move bytecode v7
}

