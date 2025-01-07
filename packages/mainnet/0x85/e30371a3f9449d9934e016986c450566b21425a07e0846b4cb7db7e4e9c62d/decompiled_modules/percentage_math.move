module 0x85e30371a3f9449d9934e016986c450566b21425a07e0846b4cb7db7e4e9c62d::percentage_math {
    public fun percent_div(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 != 0, 1);
        (arg0 * 10000 + arg1 / 2) / arg1
    }

    public fun percent_factor() : u256 {
        10000
    }

    public fun percent_mul(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        (arg0 * arg1 + 5000) / 10000
    }

    public fun percent_to_ray(arg0: u256) : u256 {
        arg0 * 100000000000000000000000
    }

    public fun ray_to_percent(arg0: u256) : u256 {
        let v0 = 100000000000000000000000 / 2;
        let v1 = v0 + arg0;
        assert!(v1 >= v0, 1);
        v1 / 100000000000000000000000
    }

    // decompiled from Move bytecode v6
}

