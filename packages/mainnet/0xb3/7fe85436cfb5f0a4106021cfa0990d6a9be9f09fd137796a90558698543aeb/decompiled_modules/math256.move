module 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256 {
    public fun add(arg0: u256, arg1: u256) : u256 {
        arg0 + arg1
    }

    public fun average(arg0: u256, arg1: u256) : u256 {
        (arg0 & arg1) + (arg0 ^ arg1) / 2
    }

    public fun average_vector(arg0: vector<u256>) : u256 {
        let v0 = 0x1::vector::length<u256>(&arg0);
        if (v0 == 0) {
            return 0
        };
        sum(arg0) / (v0 as u256)
    }

    public fun clamp(arg0: u256, arg1: u256, arg2: u256) : u256 {
        min(arg2, max(arg1, arg0))
    }

    public fun diff(arg0: u256, arg1: u256) : u256 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun div_down(arg0: u256, arg1: u256) : u256 {
        arg0 / arg1
    }

    public fun div_up(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else {
            1 + (arg0 - 1) / arg1
        }
    }

    public fun log10_down(arg0: u256) : u8 {
        let v0 = 0;
        let v1 = v0;
        if (arg0 >= 10000000000000000000000000000000000000000000000000000000000000000) {
            arg0 = arg0 / 10000000000000000000000000000000000000000000000000000000000000000;
            v1 = v0 + 64;
        };
        if (arg0 >= 100000000000000000000000000000000) {
            arg0 = arg0 / 100000000000000000000000000000000;
            v1 = v1 + 32;
        };
        if (arg0 >= 10000000000000000) {
            arg0 = arg0 / 10000000000000000;
            v1 = v1 + 16;
        };
        if (arg0 >= 100000000) {
            arg0 = arg0 / 100000000;
            v1 = v1 + 8;
        };
        if (arg0 >= 10000) {
            arg0 = arg0 / 10000;
            v1 = v1 + 4;
        };
        if (arg0 >= 100) {
            arg0 = arg0 / 100;
            v1 = v1 + 2;
        };
        if (arg0 >= 10) {
            v1 = v1 + 1;
        };
        v1
    }

    public fun log10_up(arg0: u256) : u8 {
        let v0 = log10_down(arg0);
        let v1 = if (pow(10, (v0 as u256)) < arg0) {
            1
        } else {
            0
        };
        v0 + v1
    }

    public fun log256_down(arg0: u256) : u8 {
        let v0 = 0;
        let v1 = v0;
        if (arg0 >> 128 > 0) {
            arg0 = arg0 >> 128;
            v1 = v0 + 16;
        };
        if (arg0 >> 64 > 0) {
            arg0 = arg0 >> 64;
            v1 = v1 + 8;
        };
        if (arg0 >> 32 > 0) {
            arg0 = arg0 >> 32;
            v1 = v1 + 4;
        };
        if (arg0 >> 16 > 0) {
            arg0 = arg0 >> 16;
            v1 = v1 + 2;
        };
        if (arg0 >> 8 > 0) {
            v1 = v1 + 1;
        };
        v1
    }

    public fun log256_up(arg0: u256) : u8 {
        let v0 = log256_down(arg0);
        let v1 = if (1 << v0 << 3 < arg0) {
            1
        } else {
            0
        };
        v0 + v1
    }

    public fun log2_down(arg0: u256) : u8 {
        let v0 = 0;
        let v1 = v0;
        if (arg0 >> 128 > 0) {
            arg0 = arg0 >> 128;
            v1 = v0 + 128;
        };
        if (arg0 >> 64 > 0) {
            arg0 = arg0 >> 64;
            v1 = v1 + 64;
        };
        if (arg0 >> 32 > 0) {
            arg0 = arg0 >> 32;
            v1 = v1 + 32;
        };
        if (arg0 >> 16 > 0) {
            arg0 = arg0 >> 16;
            v1 = v1 + 16;
        };
        if (arg0 >> 8 > 0) {
            arg0 = arg0 >> 8;
            v1 = v1 + 8;
        };
        if (arg0 >> 4 > 0) {
            arg0 = arg0 >> 4;
            v1 = v1 + 4;
        };
        if (arg0 >> 2 > 0) {
            arg0 = arg0 >> 2;
            v1 = v1 + 2;
        };
        if (arg0 >> 1 > 0) {
            v1 = v1 + 1;
        };
        v1
    }

    public fun log2_up(arg0: u256) : u16 {
        let v0 = log2_down(arg0);
        let v1 = if (1 << (v0 as u8) < arg0) {
            1
        } else {
            0
        };
        (v0 as u16) + v1
    }

    public fun max(arg0: u256, arg1: u256) : u256 {
        if (arg0 >= arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: u256, arg1: u256) : u256 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1
    }

    public fun mul_div_down(arg0: u256, arg1: u256, arg2: u256) : u256 {
        arg0 * arg1 / arg2
    }

    public fun mul_div_up(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = if (arg0 * arg1 % arg2 > 0) {
            1
        } else {
            0
        };
        mul_div_down(arg0, arg1, arg2) + v0
    }

    public fun pow(arg0: u256, arg1: u256) : u256 {
        if (arg1 == 0) {
            1
        } else {
            let v1 = 1;
            while (arg1 > 1) {
                if (arg1 % 2 == 1) {
                    v1 = v1 * arg0;
                };
                arg1 = arg1 / 2;
                arg0 = arg0 * arg0;
            };
            v1 * arg0
        }
    }

    public fun sqrt_down(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 1 << ((log2_down(arg0) >> 1) as u8);
        let v1 = v0 + arg0 / v0 >> 1;
        let v2 = v1 + arg0 / v1 >> 1;
        let v3 = v2 + arg0 / v2 >> 1;
        let v4 = v3 + arg0 / v3 >> 1;
        let v5 = v4 + arg0 / v4 >> 1;
        let v6 = v5 + arg0 / v5 >> 1;
        let v7 = v6 + arg0 / v6 >> 1;
        min(v7, arg0 / v7)
    }

    public fun sqrt_up(arg0: u256) : u256 {
        let v0 = sqrt_down(arg0);
        let v1 = if (v0 * v0 < arg0) {
            1
        } else {
            0
        };
        v0 + v1
    }

    public fun sub(arg0: u256, arg1: u256) : u256 {
        arg0 - arg1
    }

    public fun sum(arg0: vector<u256>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u256>(&arg0)) {
            v1 = v1 + *0x1::vector::borrow<u256>(&arg0, v0);
            v0 = v0 + 1;
        };
        v1
    }

    public fun try_add(arg0: u256, arg1: u256) : (bool, u256) {
        if (arg0 == 115792089237316195423570985008687907853269984665640564039457584007913129639935 && arg1 != 0) {
            return (false, 0)
        };
        if (arg1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg0) {
            return (false, 0)
        };
        (true, arg0 + arg1)
    }

    public fun try_div_down(arg0: u256, arg1: u256) : (bool, u256) {
        if (arg1 == 0) {
            (false, 0)
        } else {
            (true, div_down(arg0, arg1))
        }
    }

    public fun try_div_up(arg0: u256, arg1: u256) : (bool, u256) {
        if (arg1 == 0) {
            (false, 0)
        } else {
            (true, div_up(arg0, arg1))
        }
    }

    public fun try_mod(arg0: u256, arg1: u256) : (bool, u256) {
        if (arg1 == 0) {
            (false, 0)
        } else {
            (true, arg0 % arg1)
        }
    }

    public fun try_mul(arg0: u256, arg1: u256) : (bool, u256) {
        if (arg1 == 0) {
            return (true, 0)
        };
        if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            (false, 0)
        } else {
            (true, arg0 * arg1)
        }
    }

    public fun try_mul_div_down(arg0: u256, arg1: u256, arg2: u256) : (bool, u256) {
        if (arg2 == 0) {
            return (false, 0)
        };
        let (v0, _) = try_mul(arg0, arg1);
        if (!v0) {
            return (false, 0)
        };
        (true, mul_div_down(arg0, arg1, arg2))
    }

    public fun try_mul_div_up(arg0: u256, arg1: u256, arg2: u256) : (bool, u256) {
        if (arg2 == 0) {
            return (false, 0)
        };
        let (v0, _) = try_mul(arg0, arg1);
        if (!v0) {
            return (false, 0)
        };
        (true, mul_div_up(arg0, arg1, arg2))
    }

    public fun try_sub(arg0: u256, arg1: u256) : (bool, u256) {
        if (arg1 > arg0) {
            (false, 0)
        } else {
            (true, arg0 - arg1)
        }
    }

    // decompiled from Move bytecode v6
}

