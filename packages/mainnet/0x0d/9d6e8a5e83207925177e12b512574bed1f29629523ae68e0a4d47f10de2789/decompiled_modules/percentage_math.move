module 0x4ccb970858a83b7790ed42c745971182d4a6413be17d14926c7a0d655b16ef66::percentage_math {
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

