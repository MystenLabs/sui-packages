module 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::math {
    public fun add(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        if (arg0 == arg2) {
            assert!(arg1 <= 18446744073709551615 - arg3, 3001);
            (arg0, arg1 + arg3)
        } else if (arg1 >= arg3) {
            (arg0, arg1 - arg3)
        } else {
            (arg2, arg3 - arg1)
        }
    }

    public fun compare(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        arg0 != arg2 && arg0 == 0 || arg0 == 0 && arg1 > arg3 || arg1 < arg3
    }

    public fun get_scale_factor(arg0: u64) : u64 {
        let v0 = vector[1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000, 1000000000, 10000000000, 100000000000, 1000000000000, 10000000000000, 100000000000000, 1000000000000000, 10000000000000000, 100000000000000000, 1000000000000000000];
        assert!(arg0 < 0x1::vector::length<u64>(&v0), 3002);
        *0x1::vector::borrow<u64>(&v0, arg0)
    }

    public fun is_positive(arg0: u64) : bool {
        arg0 == 0
    }

    public fun multiply(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        if (arg1 == 0 || arg3 == 0) {
            (0, 0)
        } else {
            let v2 = if (arg0 == arg2) {
                0
            } else {
                1
            };
            assert!(arg1 <= 18446744073709551615 / arg3, 3001);
            let v3 = if (arg4 > 0) {
                scale_down(arg1 * arg3, arg4)
            } else {
                arg1 * arg3
            };
            (v2, v3)
        }
    }

    public fun scale_down(arg0: u64, arg1: u64) : u64 {
        let v0 = vector[1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000, 1000000000, 10000000000, 100000000000, 1000000000000, 10000000000000, 100000000000000, 1000000000000000, 10000000000000000, 100000000000000000, 1000000000000000000];
        assert!(arg1 < 0x1::vector::length<u64>(&v0), 3002);
        arg0 / *0x1::vector::borrow<u64>(&v0, arg1)
    }

    public fun scale_up(arg0: u64, arg1: u64) : u64 {
        let v0 = vector[1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000, 1000000000, 10000000000, 100000000000, 1000000000000, 10000000000000, 100000000000000, 1000000000000000, 10000000000000000, 100000000000000000, 1000000000000000000];
        assert!(arg1 < 0x1::vector::length<u64>(&v0), 3002);
        let v1 = *0x1::vector::borrow<u64>(&v0, arg1);
        assert!(arg0 == 0 || v1 <= 18446744073709551615 / arg0, 3005);
        arg0 * v1
    }

    // decompiled from Move bytecode v6
}

