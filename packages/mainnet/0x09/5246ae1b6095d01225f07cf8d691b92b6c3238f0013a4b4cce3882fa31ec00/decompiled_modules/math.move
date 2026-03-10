module 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_div_by_zero());
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= (18446744073709551615 as u128), 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_overflow());
        (v0 as u64)
    }

    public fun safe_add(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_overflow());
        arg0 + arg1
    }

    public fun safe_div(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 != 0, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_div_by_zero());
        arg0 / arg1
    }

    public fun safe_mul(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            0
        } else {
            assert!(arg0 <= 18446744073709551615 / arg1, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_overflow());
            arg0 * arg1
        }
    }

    public fun safe_sub(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_overflow());
        arg0 - arg1
    }

    public fun sqrt_u128(arg0: u128) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        assert!(arg0 <= (18446744073709551615 as u128), 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_overflow());
        (arg0 as u64)
    }

    // decompiled from Move bytecode v6
}

