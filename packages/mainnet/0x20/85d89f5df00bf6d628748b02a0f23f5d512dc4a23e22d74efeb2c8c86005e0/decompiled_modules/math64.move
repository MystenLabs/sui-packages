module 0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math64 {
    public fun add(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1
    }

    public fun sub(arg0: u64, arg1: u64) : u64 {
        arg0 - arg1
    }

    public fun log10_down(arg0: u64) : u8 {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math256::log10_down((arg0 as u256))
    }

    public fun log10_up(arg0: u64) : u8 {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math256::log10_up((arg0 as u256))
    }

    public fun log256_down(arg0: u64) : u8 {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math256::log256_down((arg0 as u256))
    }

    public fun log256_up(arg0: u64) : u8 {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math256::log256_up((arg0 as u256))
    }

    public fun log2_down(arg0: u64) : u8 {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math256::log2_down((arg0 as u256))
    }

    public fun log2_up(arg0: u64) : u16 {
        0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math256::log2_up((arg0 as u256))
    }

    public fun mul_div_down(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math256::mul_div_down((arg0 as u256), (arg1 as u256), (arg2 as u256)) as u64)
    }

    public fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math256::mul_div_up((arg0 as u256), (arg1 as u256), (arg2 as u256)) as u64)
    }

    public fun pow(arg0: u64, arg1: u64) : u64 {
        (0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math256::pow((arg0 as u256), (arg1 as u256)) as u64)
    }

    public fun sqrt_down(arg0: u64) : u64 {
        (0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math256::sqrt_down((arg0 as u256)) as u64)
    }

    public fun sqrt_up(arg0: u64) : u64 {
        (0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math256::sqrt_up((arg0 as u256)) as u64)
    }

    public fun try_mul(arg0: u64, arg1: u64) : (bool, u64) {
        let (v0, v1) = 0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math256::try_mul((arg0 as u256), (arg1 as u256));
        if (!v0 || v1 > 18446744073709551615) {
            (false, 0)
        } else {
            (true, (v1 as u64))
        }
    }

    public fun try_mul_div_down(arg0: u64, arg1: u64, arg2: u64) : (bool, u64) {
        let (v0, v1) = 0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math256::try_mul_div_down((arg0 as u256), (arg1 as u256), (arg2 as u256));
        if (!v0 || v1 > 18446744073709551615) {
            (false, 0)
        } else {
            (true, (v1 as u64))
        }
    }

    public fun try_mul_div_up(arg0: u64, arg1: u64, arg2: u64) : (bool, u64) {
        let (v0, v1) = 0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::math256::try_mul_div_up((arg0 as u256), (arg1 as u256), (arg2 as u256));
        if (!v0 || v1 > 18446744073709551615) {
            (false, 0)
        } else {
            (true, (v1 as u64))
        }
    }

    public fun average(arg0: u64, arg1: u64) : u64 {
        (arg0 & arg1) + (arg0 ^ arg1) / 2
    }

    public fun average_vector(arg0: vector<u64>) : u64 {
        let v0 = 0x1::vector::length<u64>(&arg0);
        if (v0 == 0) {
            return 0
        };
        sum(arg0) / (v0 as u64)
    }

    public fun clamp(arg0: u64, arg1: u64, arg2: u64) : u64 {
        min(arg2, max(arg1, arg0))
    }

    public fun diff(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun div_down(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1
    }

    public fun div_up(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            0
        } else {
            1 + (arg0 - 1) / arg1
        }
    }

    public fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
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

    public fun sum(arg0: vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0)) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg0, v0);
            v0 = v0 + 1;
        };
        v1
    }

    public fun try_add(arg0: u64, arg1: u64) : (bool, u64) {
        let v0 = (arg0 as u256) + (arg1 as u256);
        if (v0 > 18446744073709551615) {
            (false, 0)
        } else {
            (true, (v0 as u64))
        }
    }

    public fun try_div_down(arg0: u64, arg1: u64) : (bool, u64) {
        if (arg1 == 0) {
            (false, 0)
        } else {
            (true, div_down(arg0, arg1))
        }
    }

    public fun try_div_up(arg0: u64, arg1: u64) : (bool, u64) {
        if (arg1 == 0) {
            (false, 0)
        } else {
            (true, div_up(arg0, arg1))
        }
    }

    public fun try_mod(arg0: u64, arg1: u64) : (bool, u64) {
        if (arg1 == 0) {
            (false, 0)
        } else {
            (true, arg0 % arg1)
        }
    }

    public fun try_sub(arg0: u64, arg1: u64) : (bool, u64) {
        if (arg1 > arg0) {
            (false, 0)
        } else {
            (true, arg0 - arg1)
        }
    }

    public fun wrapping_add(arg0: u64, arg1: u64) : u64 {
        (0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::int::wrap(0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::int::add(0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::int::from_u64(arg0), 0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::int::from_u64(arg1)), 18446744073709551616) as u64)
    }

    public fun wrapping_mul(arg0: u64, arg1: u64) : u64 {
        (0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::int::wrap(0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::int::mul(0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::int::from_u64(arg0), 0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::int::from_u64(arg1)), 18446744073709551616) as u64)
    }

    public fun wrapping_sub(arg0: u64, arg1: u64) : u64 {
        (0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::int::wrap(0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::int::sub(0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::int::from_u64(arg0), 0x2085d89f5df00bf6d628748b02a0f23f5d512dc4a23e22d74efeb2c8c86005e0::int::from_u64(arg1)), 18446744073709551616) as u64)
    }

    // decompiled from Move bytecode v6
}

