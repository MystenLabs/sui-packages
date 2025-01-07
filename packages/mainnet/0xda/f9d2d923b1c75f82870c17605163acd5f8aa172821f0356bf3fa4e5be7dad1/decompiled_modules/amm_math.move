module 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::amm_math {
    fun d(arg0: u256, arg1: u256) : u256 {
        3 * arg0 * arg1 * arg1 / 1000000000000000000 / 1000000000000000000 + arg0 * arg0 / 1000000000000000000 * arg0 / 1000000000000000000
    }

    fun f(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 * arg1 / 1000000000000000000 * arg1 / 1000000000000000000 / 1000000000000000000 + arg0 * arg0 / 1000000000000000000 * arg0 / 1000000000000000000 * arg1 / 1000000000000000000
    }

    public fun get_output_<T0, T1, T2>(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u8) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T2>();
        assert!(v0 == v1 || 0x1::type_name::get<T1>() == v1, 2);
        if (v0 == v1) {
            if (arg0) {
                (stable_swap_output(arg1, arg2, arg3, 0x2::math::pow(10, arg4), 0x2::math::pow(10, arg5)) as u64)
            } else {
                (variable_swap_output(arg1, arg2, arg3) as u64)
            }
        } else if (arg0) {
            (stable_swap_output(arg1, arg3, arg2, 0x2::math::pow(10, arg5), 0x2::math::pow(10, arg4)) as u64)
        } else {
            (variable_swap_output(arg1, arg3, arg2) as u64)
        }
    }

    fun get_y(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = 0;
        while (v0 < 255) {
            let v1 = f(arg0, arg2);
            let v2 = arg2;
            if (v1 < arg1) {
                let v3 = (arg1 - v1) * 1000000000000000000 / d(arg0, arg2);
                arg2 = arg2 + v3;
            } else {
                let v4 = (v1 - arg1) * 1000000000000000000 / d(arg0, arg2);
                arg2 = arg2 - v4;
            };
            if (arg2 > v2) {
                if (arg2 - v2 <= 1) {
                    return arg2
                };
            } else if (v2 - arg2 <= 1) {
                return arg2
            };
            v0 = v0 + 1;
        };
        arg2
    }

    public fun k_(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u256 {
        let v0 = (arg0 as u256) * 1000000000000000000 / (arg2 as u256);
        let v1 = (arg1 as u256) * 1000000000000000000 / (arg3 as u256);
        v0 * v1 / 1000000000000000000 * (v0 * v0 / 1000000000000000000 + v1 * v1 / 1000000000000000000) / 1000000000000000000
    }

    public fun max_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun max_u256(arg0: u256, arg1: u256) : u256 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min_u256(arg0: u256, arg1: u256) : u256 {
        if (arg0 > arg1) {
            arg1
        } else {
            arg0
        }
    }

    public fun mul_sqrt(arg0: u64, arg1: u64) : u64 {
        (sqrt_u128((arg0 as u128) * (arg1 as u128)) as u64)
    }

    public fun sqrt_u128(arg0: u128) : u128 {
        if (arg0 < 4) {
            if (arg0 == 0) {
                0
            } else {
                1
            }
        } else {
            let v1 = arg0 / 2 + 1;
            while (v1 < arg0) {
                let v2 = arg0 / v1 + v1;
                v1 = v2 / 2;
            };
            arg0
        }
    }

    public fun sqrt_u256(arg0: u256) : u256 {
        let v0 = 0;
        if (arg0 > 3) {
            v0 = arg0;
            let v1 = arg0 / 2 + 1;
            while (v1 < arg0) {
                v0 = v1;
                let v2 = arg0 / v1 + v1;
                v1 = v2 / 2;
            };
        } else if (arg0 != 0) {
            v0 = 1;
        };
        v0
    }

    public fun stable_swap_output(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u256 {
        let v0 = (arg3 as u256);
        let v1 = (arg4 as u256);
        let v2 = (arg2 as u256) * 1000000000000000000 / v1;
        (v2 - get_y((arg0 as u256) * 1000000000000000000 / v0 + (arg1 as u256) * 1000000000000000000 / v0, k_(arg1, arg2, arg3, arg4), v2)) * v1 / 1000000000000000000
    }

    public fun variable_swap_output(arg0: u64, arg1: u64, arg2: u64) : u128 {
        let v0 = (arg0 as u128);
        v0 * (arg2 as u128) / (v0 + (arg1 as u128))
    }

    public fun zap_optimized_input(arg0: u256, arg1: u256, arg2: u8) : u64 {
        assert!(arg2 >= 10 && arg2 <= 50, 1);
        let (v0, v1, v2, v3) = if (arg2 == 10) {
            (399600100, 399600000, 19990, 19980)
        } else if (arg2 == 20) {
            (399200400, 399200000, 19980, 19960)
        } else if (arg2 == 30) {
            (398880900, 398800000, 19970, 19940)
        } else if (arg2 == 40) {
            (398401600, 398400000, 19960, 19920)
        } else {
            (398002500, 398000000, 19950, 19900)
        };
        (((sqrt_u256(arg0 * (arg0 * v0 + arg1 * v1)) - arg0 * v2) / v3) as u64)
    }

    // decompiled from Move bytecode v6
}

