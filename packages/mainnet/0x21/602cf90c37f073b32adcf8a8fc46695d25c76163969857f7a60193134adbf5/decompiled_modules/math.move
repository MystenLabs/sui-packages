module 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math {
    public fun abs_diff(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun add(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::overflow());
        (v0 as u64)
    }

    public fun apply_haircut_bps(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::bad_fee_bps());
        mul_div(arg0, 10000 - arg1, 10000)
    }

    public fun bps(arg0: u64, arg1: u64) : u64 {
        mul_div(arg0, arg1, 10000)
    }

    public fun bps_denominator() : u64 {
        10000
    }

    public fun deviation_bps(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        mul_div_ceil(abs_diff(arg0, arg1), 10000, arg1)
    }

    public fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun ms_per_second() : u64 {
        1000
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::overflow());
        (v0 as u64)
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::overflow());
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::overflow());
        (v0 as u64)
    }

    public fun mul_div_ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::overflow());
        let v0 = ((arg0 as u128) * (arg1 as u128) + (arg2 as u128) - 1) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::overflow());
        (v0 as u64)
    }

    public fun seconds_per_year() : u64 {
        31536000
    }

    public fun sub(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::overflow());
        arg0 - arg1
    }

    // decompiled from Move bytecode v7
}

