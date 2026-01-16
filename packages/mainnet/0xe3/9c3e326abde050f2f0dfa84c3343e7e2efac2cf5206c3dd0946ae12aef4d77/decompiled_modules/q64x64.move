module 0xe39c3e326abde050f2f0dfa84c3343e7e2efac2cf5206c3dd0946ae12aef4d77::q64x64 {
    fun get_integer(arg0: u128) : u64 {
        ((arg0 >> 64) as u64)
    }

    public fun pow(arg0: u128, arg1: u128) : u128 {
        if (arg1 == 0) {
            return 18446744073709551616
        };
        if (arg0 == 0) {
            return 0
        };
        if (arg0 == 18446744073709551616) {
            return 18446744073709551616
        };
        let v0 = arg1 > 170141183460469231731687303715884105727;
        let v1 = if (v0) {
            340282366920938463463374607431768211455 - arg1 + 1
        } else {
            arg1
        };
        assert!(v1 < 1048576, 401);
        if (arg0 > 18446744073709551616 && v1 > 64) {
            if (get_integer(arg0) >= 2) {
                assert!(v1 <= 64, 403);
            };
        };
        let v2 = if (v1 > 1000) {
            pow_iterative(arg0, v1, 18446744073709551616)
        } else {
            pow_recursive(arg0, v1, 18446744073709551616)
        };
        assert!(v2 > 0, 401);
        if (v0) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(18446744073709551616, 18446744073709551616, v2)
        } else {
            v2
        }
    }

    fun pow_iterative(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg1 == 0) {
            return arg2
        };
        if (arg1 == 1) {
            return arg0
        };
        let v0 = arg2;
        let v1 = arg1;
        while (v1 > 0) {
            if (v1 & 1 == 1) {
                v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(v0, arg0, arg2);
            };
            v1 = v1 >> 1;
            if (v1 > 0) {
                arg0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(arg0, arg0, arg2);
            };
        };
        v0
    }

    fun pow_recursive(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg1 > 1000) {
            return pow_iterative(arg0, arg1, arg2)
        };
        if (arg1 == 0) {
            arg2
        } else if (arg1 == 1) {
            arg0
        } else if (arg1 & 1 == 0) {
            pow_recursive(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(arg0, arg0, arg2), arg1 >> 1, arg2)
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(arg0, pow_recursive(arg0, arg1 - 1, arg2), arg2)
        }
    }

    public fun scale() : u128 {
        18446744073709551616
    }

    public fun scale_offset() : u8 {
        64
    }

    // decompiled from Move bytecode v6
}

