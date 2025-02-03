module 0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math128 {
    public fun add(arg0: u128, arg1: u128) : u128 {
        arg0 + arg1
    }

    public fun average(arg0: u128, arg1: u128) : u128 {
        (arg0 & arg1) + (arg0 ^ arg1) / 2
    }

    public fun average_vector(arg0: vector<u128>) : u128 {
        let v0 = 0x1::vector::length<u128>(&arg0);
        if (v0 == 0) {
            return 0
        };
        sum(arg0) / (v0 as u128)
    }

    public fun clamp(arg0: u128, arg1: u128, arg2: u128) : u128 {
        min(arg2, max(arg1, arg0))
    }

    public fun diff(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun div_down(arg0: u128, arg1: u128) : u128 {
        arg0 / arg1
    }

    public fun div_up(arg0: u128, arg1: u128) : u128 {
        if (arg0 == 0) {
            0
        } else {
            1 + (arg0 - 1) / arg1
        }
    }

    public fun log10_down(arg0: u128) : u8 {
        0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math256::log10_down((arg0 as u256))
    }

    public fun log10_up(arg0: u128) : u8 {
        0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math256::log10_up((arg0 as u256))
    }

    public fun log256_down(arg0: u128) : u8 {
        0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math256::log256_down((arg0 as u256))
    }

    public fun log256_up(arg0: u128) : u8 {
        0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math256::log256_up((arg0 as u256))
    }

    public fun log2_down(arg0: u128) : u8 {
        0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math256::log2_down((arg0 as u256))
    }

    public fun log2_up(arg0: u128) : u16 {
        0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math256::log2_up((arg0 as u256))
    }

    public fun max(arg0: u128, arg1: u128) : u128 {
        if (arg0 >= arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul(arg0: u128, arg1: u128) : u128 {
        arg0 * arg1
    }

    public fun mul_div_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math256::mul_div_down((arg0 as u256), (arg1 as u256), (arg2 as u256)) as u128)
    }

    public fun mul_div_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math256::mul_div_up((arg0 as u256), (arg1 as u256), (arg2 as u256)) as u128)
    }

    public fun pow(arg0: u128, arg1: u128) : u128 {
        (0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math256::pow((arg0 as u256), (arg1 as u256)) as u128)
    }

    public fun sqrt_down(arg0: u128) : u128 {
        (0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math256::sqrt_down((arg0 as u256)) as u128)
    }

    public fun sqrt_up(arg0: u128) : u128 {
        (0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math256::sqrt_up((arg0 as u256)) as u128)
    }

    public fun sub(arg0: u128, arg1: u128) : u128 {
        arg0 - arg1
    }

    public fun sum(arg0: vector<u128>) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u128>(&arg0)) {
            v1 = v1 + *0x1::vector::borrow<u128>(&arg0, v0);
            v0 = v0 + 1;
        };
        v1
    }

    public fun try_add(arg0: u128, arg1: u128) : (bool, u128) {
        let v0 = (arg0 as u256) + (arg1 as u256);
        if (v0 > 340282366920938463463374607431768211455) {
            (false, 0)
        } else {
            (true, (v0 as u128))
        }
    }

    public fun try_div_down(arg0: u128, arg1: u128) : (bool, u128) {
        if (arg1 == 0) {
            (false, 0)
        } else {
            (true, div_down(arg0, arg1))
        }
    }

    public fun try_div_up(arg0: u128, arg1: u128) : (bool, u128) {
        if (arg1 == 0) {
            (false, 0)
        } else {
            (true, div_up(arg0, arg1))
        }
    }

    public fun try_mod(arg0: u128, arg1: u128) : (bool, u128) {
        if (arg1 == 0) {
            (false, 0)
        } else {
            (true, arg0 % arg1)
        }
    }

    public fun try_mul(arg0: u128, arg1: u128) : (bool, u128) {
        let (v0, v1) = 0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math256::try_mul((arg0 as u256), (arg1 as u256));
        if (!v0 || v1 > 340282366920938463463374607431768211455) {
            (false, 0)
        } else {
            (true, (v1 as u128))
        }
    }

    public fun try_mul_div_down(arg0: u128, arg1: u128, arg2: u128) : (bool, u128) {
        let (v0, v1) = 0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math256::try_mul_div_down((arg0 as u256), (arg1 as u256), (arg2 as u256));
        if (!v0 || v1 > 340282366920938463463374607431768211455) {
            (false, 0)
        } else {
            (true, (v1 as u128))
        }
    }

    public fun try_mul_div_up(arg0: u128, arg1: u128, arg2: u128) : (bool, u128) {
        let (v0, v1) = 0x2e49997ac212144a9ae9374cb1a3d6c4a05579ec59fc24e6297055ba9740ddff::math256::try_mul_div_up((arg0 as u256), (arg1 as u256), (arg2 as u256));
        if (!v0 || v1 > 340282366920938463463374607431768211455) {
            (false, 0)
        } else {
            (true, (v1 as u128))
        }
    }

    public fun try_sub(arg0: u128, arg1: u128) : (bool, u128) {
        if (arg1 > arg0) {
            (false, 0)
        } else {
            (true, arg0 - arg1)
        }
    }

    // decompiled from Move bytecode v6
}

