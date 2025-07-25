module 0xb2f3f2134577e6cd3ef312b099f05e48964301262a1158416143e57358d2e455::math {
    public fun find_greatest_from_2(arg0: u8, arg1: u8) : u8 {
        if (arg0 >= arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun find_greatest_from_3(arg0: u8, arg1: u8, arg2: u8) : u8 {
        let v0 = if (arg0 >= arg1) {
            arg0
        } else {
            arg1
        };
        if (v0 >= arg2) {
            v0
        } else {
            arg2
        }
    }

    public fun find_greatest_from_4(arg0: u8, arg1: u8, arg2: u8, arg3: u8) : u8 {
        let v0 = if (arg0 >= arg1) {
            arg0
        } else {
            arg1
        };
        let v1 = if (v0 >= arg2) {
            v0
        } else {
            arg2
        };
        if (v1 >= arg3) {
            v1
        } else {
            arg3
        }
    }

    public fun find_greatest_from_5(arg0: u8, arg1: u8, arg2: u8, arg3: u8, arg4: u8) : u8 {
        let v0 = if (arg0 >= arg1) {
            arg0
        } else {
            arg1
        };
        let v1 = if (v0 >= arg2) {
            v0
        } else {
            arg2
        };
        let v2 = if (v1 >= arg3) {
            v1
        } else {
            arg3
        };
        if (v2 >= arg4) {
            v2
        } else {
            arg4
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun max_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 >= arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun max_u256(arg0: u256, arg1: u256) : u256 {
        if (arg0 >= arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun max_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun merge(arg0: vector<u256>, arg1: vector<u256>) : vector<u256> {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<u256>(&arg0) && v2 < 0x1::vector::length<u256>(&arg1)) {
            let v3 = *0x1::vector::borrow<u256>(&arg0, v1);
            let v4 = *0x1::vector::borrow<u256>(&arg1, v2);
            if (v3 >= v4) {
                0x1::vector::push_back<u256>(&mut v0, v3);
                v1 = v1 + 1;
                continue
            };
            0x1::vector::push_back<u256>(&mut v0, v4);
            v2 = v2 + 1;
        };
        while (v1 < 0x1::vector::length<u256>(&arg0)) {
            0x1::vector::push_back<u256>(&mut v0, *0x1::vector::borrow<u256>(&arg0, v1));
            v1 = v1 + 1;
        };
        while (v2 < 0x1::vector::length<u256>(&arg1)) {
            0x1::vector::push_back<u256>(&mut v0, *0x1::vector::borrow<u256>(&arg1, v2));
            v2 = v2 + 1;
        };
        v0
    }

    public fun min_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 <= arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min_u256(arg0: u256, arg1: u256) : u256 {
        if (arg0 <= arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 <= arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 13906834560890437633);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u64 {
        assert!(arg2 != 0, 13906834595250176001);
        ((arg0 * arg1 / arg2) as u64)
    }

    public fun mul_div_u256(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 != 0, 13906834625314947073);
        ((arg0 * arg1 / arg2) as u256)
    }

    public fun mul_to_u128(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun overflow_add(arg0: u128, arg1: u128) : u128 {
        let v0 = 340282366920938463463374607431768211455 - arg1;
        if (v0 < arg0) {
            return arg0 - v0
        };
        arg0 + arg1
    }

    public fun overflow_add_u256(arg0: u256, arg1: u256) : u256 {
        let v0 = 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1;
        if (v0 < arg0) {
            return arg0 - v0
        };
        arg0 + arg1
    }

    public fun pow(arg0: u128, arg1: u128) : u128 {
        let v0 = 1;
        while (arg1 >= 1) {
            if (arg1 % 2 == 0) {
                arg0 = arg0 * arg0;
                arg1 = arg1 / 2;
                continue
            };
            v0 = v0 * arg0;
            arg1 = arg1 - 1;
        };
        v0
    }

    public fun pow_10(arg0: u8) : u64 {
        (pow(10, (arg0 as u128)) as u64)
    }

    public fun pow_10_u256(arg0: u8) : u256 {
        pow_u256(10, (arg0 as u128))
    }

    public fun pow_nu256(arg0: u256, arg1: u128) : u256 {
        let v0 = 1;
        while (arg1 >= 1) {
            if (arg1 % 2 == 0) {
                arg0 = arg0 * arg0;
                arg1 = arg1 / 2;
                continue
            };
            v0 = v0 * arg0;
            arg1 = arg1 - 1;
        };
        v0
    }

    public fun pow_u256(arg0: u128, arg1: u128) : u256 {
        let v0 = 1;
        let v1 = (arg0 as u256);
        while (arg1 >= 1) {
            if (arg1 % 2 == 0) {
                v1 = v1 * v1;
                arg1 = arg1 / 2;
                continue
            };
            v0 = v0 * v1;
            arg1 = arg1 - 1;
        };
        v0
    }

    fun slice_vector(arg0: &vector<u256>, arg1: u64, arg2: u64) : vector<u256> {
        let v0 = 0x1::vector::empty<u256>();
        while (arg1 < arg2 && arg1 < 0x1::vector::length<u256>(arg0)) {
            0x1::vector::push_back<u256>(&mut v0, *0x1::vector::borrow<u256>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun sort(arg0: vector<u128>) : vector<u128> {
        if (0x1::vector::length<u128>(&arg0) <= 1) {
            return arg0
        };
        let v0 = 0x1::vector::length<u128>(&arg0);
        let v1 = 0;
        let v2 = 0x1::vector::empty<u256>();
        while (v1 < v0) {
            0x1::vector::push_back<u256>(&mut v2, (*0x1::vector::borrow<u128>(&arg0, v1) as u256));
            v1 = v1 + 1;
        };
        let v3 = 0x1::vector::length<u128>(&arg0) / 2;
        let v4 = merge(sort_u256(slice_vector(&v2, 0, v3)), sort_u256(slice_vector(&v2, v3, 0x1::vector::length<u128>(&arg0))));
        let v5 = 0;
        let v6 = 0x1::vector::empty<u128>();
        while (v5 < v0) {
            0x1::vector::push_back<u128>(&mut v6, (*0x1::vector::borrow<u256>(&v4, v5) as u128));
            v5 = v5 + 1;
        };
        v6
    }

    public fun sort_u256(arg0: vector<u256>) : vector<u256> {
        if (0x1::vector::length<u256>(&arg0) <= 1) {
            return arg0
        };
        let v0 = 0x1::vector::length<u256>(&arg0) / 2;
        merge(sort_u256(slice_vector(&arg0, 0, v0)), sort_u256(slice_vector(&arg0, v0, 0x1::vector::length<u256>(&arg0))))
    }

    public fun sqrt(arg0: u128) : u64 {
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
            (arg0 as u64)
        }
    }

    public fun sqrt_int(arg0: u256) : u128 {
        let v0 = 1000000000000000000;
        if (arg0 == 0) {
            return 0
        } else {
            let v1 = (arg0 + v0) / 2;
            let v2 = 0;
            while (v2 < 256) {
                if (v1 == arg0) {
                    return (arg0 as u128)
                };
                let v3 = arg0 * v0 / v1 + v1;
                v1 = v3 / 2;
                v2 = v2 + 1;
            };
            abort 13906835480013570051
        };
    }

    public fun sqrt_int_u256(arg0: u256) : u256 {
        let v0 = 1000000000000000000;
        if (arg0 == 0) {
            return 0
        } else {
            let v1 = (arg0 + v0) / 2;
            let v2 = 0;
            while (v2 < 256) {
                if (v1 == arg0) {
                    return arg0
                };
                let v3 = arg0 * v0 / v1 + v1;
                v1 = v3 / 2;
                v2 = v2 + 1;
            };
            abort 13906835583092785155
        };
    }

    public fun sub_from_max_u256(arg0: u256) : u256 {
        115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg0
    }

    public fun subtract_mod(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun subtract_mod_u256(arg0: u256, arg1: u256) : u256 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    // decompiled from Move bytecode v6
}

