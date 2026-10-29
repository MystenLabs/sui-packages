module 0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::settlement_math {
    fun from_subtraction(arg0: u128, arg1: u128) : (u128, bool) {
        if (arg0 >= arg1) {
            (arg0 - arg1, true)
        } else {
            (arg1 - arg0, false)
        }
    }

    public fun margin_left(arg0: bool, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128) : u128 {
        let v0 = if (arg0) {
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::sub(arg1 + arg2 * arg4 / arg3, arg2)
        } else {
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::sub(arg1 + arg2, arg2 * arg4 / arg3)
        };
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::min(v0, arg5)
    }

    public fun max_removable_margin(arg0: bool, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128) : u128 {
        if (arg0) {
            let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_mul(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_mul(arg4, arg5), 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_uint() - arg1);
            let (v2, v3) = from_subtraction(arg2, arg3);
            let v4 = if (v3) {
                v2 + v1
            } else if (v2 > v1) {
                0
            } else {
                v1 - v2
            };
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::min(arg2, v4)
        } else {
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::min(arg2, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::sub(arg2 + arg3, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_mul(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_mul(arg4, arg5), 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_uint() + arg1)))
        }
    }

    public fun target_margin(arg0: bool, arg1: u128, arg2: u128, arg3: u128, arg4: u128) : u128 {
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_mul(arg2, arg4);
        if (arg0) {
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::sub(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_div(v0, arg3) + arg1, v0)
        } else {
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::sub(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_div(v0, arg3) + v0, arg1)
        }
    }

    // decompiled from Move bytecode v7
}

