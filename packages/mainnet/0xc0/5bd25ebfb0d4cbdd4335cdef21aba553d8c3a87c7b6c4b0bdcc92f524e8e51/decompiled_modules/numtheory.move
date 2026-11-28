module 0xc05bd25ebfb0d4cbdd4335cdef21aba553d8c3a87c7b6c4b0bdcc92f524e8e51::numtheory {
    fun add_reduced(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = arg2 - arg1;
        if (arg0 >= v0) {
            arg0 - v0
        } else {
            arg0 + arg1
        }
    }

    public fun binary_gcd(arg0: u256, arg1: u256) : u256 {
        let v0 = arg0;
        let v1 = arg1;
        let v2 = 0;
        while (v0 != 0 && v1 != 0) {
            if (v0 & 1 == 0) {
                v0 = v0 >> 1;
                if (v1 & 1 == 0) {
                    v1 = v1 >> 1;
                    v2 = v2 + 1;
                    continue
                } else {
                    continue
                };
            };
            if (v1 & 1 == 0) {
                v1 = v1 >> 1;
                continue
            };
            if (v0 >= v1) {
                v0 = v0 - v1;
                continue
            };
            v1 = v1 - v0;
        };
        v0 + v1 << v2
    }

    fun check_record(arg0: &vector<u256>, arg1: u64, arg2: &vector<u256>) : (bool, u256, u64) {
        let v0 = 0x1::vector::length<u256>(arg0);
        if (v0 - arg1 < 3) {
            return (false, 0, v0)
        };
        let v1 = *0x1::vector::borrow<u256>(arg0, arg1);
        let v2 = *0x1::vector::borrow<u256>(arg0, arg1 + 1);
        let v3 = *0x1::vector::borrow<u256>(arg0, arg1 + 2);
        let v4 = arg1 + 3;
        if (v1 < 2) {
            return (false, 0, v0)
        };
        if (v3 > ((v0 - v4) as u256)) {
            return (false, 0, v0)
        };
        let v5 = v4 + (v3 as u64);
        let v6 = v1 - 1;
        if (mod_pow(v2, v6, v1) != 1) {
            return (false, 0, v0)
        };
        let v7 = v6;
        let v8 = true;
        while (v8 && v4 < v5) {
            let v9 = *0x1::vector::borrow<u256>(arg0, v4);
            if (v9 >= (0x1::vector::length<u256>(arg2) as u256)) {
                v8 = false;
            } else {
                let v10 = *0x1::vector::borrow<u256>(arg2, (v9 as u64));
                if (v7 % v10 != 0) {
                    v8 = false;
                } else {
                    v7 = v7 / v10;
                    if (v10 != 0) {
                        v8 = mod_pow(v2, v6 / v10, v1) != 1;
                    };
                };
            };
            v4 = v4 + 1;
        };
        let v11 = v8 && v7 == 1;
        (v11, v1, v5)
    }

    public fun crt(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : u256 {
        let v0 = arg0 % arg1;
        v0 + arg1 * mod_mul(mod_sub(arg2, v0, arg3), mod_inverse(arg1, arg3), arg3)
    }

    public fun ext_gcd(arg0: u256, arg1: u256) : (u256, u256, u256, bool) {
        let v0 = arg1;
        let v1 = 1;
        let v2 = 0;
        let v3 = 0;
        let v4 = 1;
        let v5 = false;
        while (v0 != 0) {
            let v6 = arg0 / v0;
            v0 = arg0 % v0;
            v2 = v1 + v6 * v2;
            v4 = v3 + v6 * v4;
            v5 = !v5;
        };
        (arg0, v1, v3, v5)
    }

    public fun gcd(arg0: u256, arg1: u256) : u256 {
        while (arg1 != 0) {
            arg1 = arg0 % arg1;
        };
        arg0
    }

    public fun is_probable_prime(arg0: u256, arg1: vector<u256>) : bool {
        let v0 = 0;
        let v1 = arg0 >= 2;
        while (v1 && v0 < 0x1::vector::length<u256>(&arg1)) {
            v1 = miller_rabin(arg0, *0x1::vector::borrow<u256>(&arg1, v0));
            v0 = v0 + 1;
        };
        v1
    }

    public fun jacobi(arg0: u256, arg1: u256) : u8 {
        assert!(arg1 & 1 == 1, 2);
        let v0 = arg0 % arg1;
        let v1 = false;
        while (v0 != 0) {
            if (v0 & 1 == 0) {
                v0 = v0 >> 1;
                let v2 = arg1 & 7;
                if (v2 == 3 || v2 == 5) {
                    v1 = !v1;
                    continue
                } else {
                    continue
                };
            };
            if (v0 & 3 == 3 && arg1 & 3 == 3) {
                v1 = !v1;
            };
            v0 = arg1 % v0;
        };
        if (arg1 != 1) {
            0
        } else if (v1) {
            255
        } else {
            1
        }
    }

    public fun lcm(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        arg0 / gcd(arg0, arg1) * arg1
    }

    public fun miller_rabin(arg0: u256, arg1: u256) : bool {
        if (arg0 < 4) {
            return arg0 >= 2
        };
        if (arg0 & 1 == 0) {
            return false
        };
        let v0 = arg1 % arg0;
        if (v0 == 0) {
            return true
        };
        let v1 = arg0 - 1;
        let v2 = v1;
        let v3 = 0;
        while (v2 & 1 == 0) {
            v2 = v2 >> 1;
            v3 = v3 + 1;
        };
        let v4 = mod_pow(v0, v2, arg0);
        if (v4 == 1 || v4 == v1) {
            return true
        };
        let v5 = 1;
        let v6 = false;
        while (!v6 && v5 < v3) {
            let v7 = mod_mul(v4, v4, arg0);
            v4 = v7;
            v6 = v7 == v1;
            v5 = v5 + 1;
        };
        v6
    }

    public fun mod_add(arg0: u256, arg1: u256, arg2: u256) : u256 {
        add_reduced(arg0 % arg2, arg1 % arg2, arg2)
    }

    public fun mod_inverse(arg0: u256, arg1: u256) : u256 {
        let (v0, v1, _, v3) = ext_gcd(arg0 % arg1, arg1);
        assert!(v0 == 1, 1);
        let v4 = v1 % arg1;
        if (v3 && v4 != 0) {
            arg1 - v4
        } else {
            v4
        }
    }

    public fun mod_mul(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = arg0 % arg2;
        let v1 = arg1 % arg2;
        if (v0 == 0 || v1 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v0) {
            return v0 * v1 % arg2
        };
        let v2 = 0;
        while (v1 > 0) {
            if (v1 & 1 == 1) {
                v2 = add_reduced(v2, v0, arg2);
            };
            v0 = add_reduced(v0, v0, arg2);
            v1 = v1 >> 1;
        };
        v2
    }

    public fun mod_pow(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = arg0 % arg2;
        let v1 = arg1;
        let v2 = 1 % arg2;
        while (v1 > 0) {
            if (v1 & 1 == 1) {
                v2 = mod_mul(v2, v0, arg2);
            };
            v1 = v1 >> 1;
            if (v1 > 0) {
                v0 = mod_mul(v0, v0, arg2);
            };
        };
        v2
    }

    public fun mod_sub(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = arg0 % arg2;
        let v1 = arg1 % arg2;
        if (v0 >= v1) {
            v0 - v1
        } else {
            arg2 - v1 - v0
        }
    }

    public fun verify_pratt(arg0: u256, arg1: vector<u256>) : bool {
        let v0 = 0x1::vector::length<u256>(&arg1);
        let v1 = vector[];
        let v2 = 0;
        let v3 = true;
        while (v3 && v2 < v0) {
            let (v4, v5, v6) = check_record(&arg1, v2, &v1);
            if (v4) {
                0x1::vector::push_back<u256>(&mut v1, v5);
            };
            v3 = v4;
            let v7 = if (v6 > v2) {
                v6
            } else {
                v0
            };
            v2 = v7;
        };
        let v8 = 0x1::vector::length<u256>(&v1);
        if (v3) {
            if (v8 > 0) {
                *0x1::vector::borrow<u256>(&v1, v8 - 1) == arg0
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v7
}

