module 0x9fc07f422912997425114d97ccdfd4ff31b7d1f1b314cd41b57f5cb3697cedab::ray_math {
    public fun half_ray() : u256 {
        500000000000000000000000000
    }

    public fun half_wad() : u256 {
        500000000000000000
    }

    public fun ray() : u256 {
        1000000000000000000000000000
    }

    public fun ray_div(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 != 0, 1103);
        let v0 = arg1 / 2;
        assert!(arg0 <= (0x2::address::max() - v0) / 1000000000000000000000000000, 1101);
        (arg0 * 1000000000000000000000000000 + v0) / arg1
    }

    public fun ray_mul(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= (0x2::address::max() - 500000000000000000000000000) / arg1, 1101);
        (arg0 * arg1 + 500000000000000000000000000) / 1000000000000000000000000000
    }

    public fun ray_to_wad(arg0: u256) : u256 {
        let v0 = 1000000000 / 2;
        let v1 = v0 + arg0;
        assert!(v1 >= v0, 1102);
        v1 / 1000000000
    }

    public fun wad() : u256 {
        1000000000000000000
    }

    public fun wad_div(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 != 0, 1103);
        let v0 = arg1 / 2;
        assert!(arg0 <= (0x2::address::max() - v0) / 1000000000000000000, 1101);
        (arg0 * 1000000000000000000 + v0) / arg1
    }

    public fun wad_mul(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= (0x2::address::max() - 500000000000000000) / arg1, 1101);
        (arg0 * arg1 + 500000000000000000) / 1000000000000000000
    }

    public fun wad_to_ray(arg0: u256) : u256 {
        let v0 = arg0 * 1000000000;
        assert!(v0 / 1000000000 == arg0, 1101);
        v0
    }

    // decompiled from Move bytecode v6
}

