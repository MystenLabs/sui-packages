module 0xa7397ceb1e6ba129bad0ddc1217bbc12b3556029e91489624e09e1bc43e862e2::settlement_math {
    fun from_subtraction(arg0: u128, arg1: u128) : (u128, bool) {
        if (arg0 >= arg1) {
            (arg0 - arg1, true)
        } else {
            (arg1 - arg0, false)
        }
    }

    public fun margin_left(arg0: bool, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128) : u128 {
        let v0 = if (arg0) {
            0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::sub(arg1 + arg2 * arg4 / arg3, arg2)
        } else {
            0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::sub(arg1 + arg2, arg2 * arg4 / arg3)
        };
        0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::min(v0, arg5)
    }

    public fun max_removable_margin(arg0: bool, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128) : u128 {
        if (arg0) {
            let v1 = 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul(0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul(arg4, arg5), 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_uint() - arg1);
            let (v2, v3) = from_subtraction(arg2, arg3);
            let v4 = if (v3) {
                v2 + v1
            } else if (v2 > v1) {
                0
            } else {
                v1 - v2
            };
            0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::min(arg2, v4)
        } else {
            0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::min(arg2, 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::sub(arg2 + arg3, 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul(0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul(arg4, arg5), 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_uint() + arg1)))
        }
    }

    public fun target_margin(arg0: bool, arg1: u128, arg2: u128, arg3: u128, arg4: u128) : u128 {
        let v0 = 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul(arg2, arg4);
        if (arg0) {
            0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::sub(0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_div(v0, arg3) + arg1, v0)
        } else {
            0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::sub(0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_div(v0, arg3) + v0, arg1)
        }
    }

    // decompiled from Move bytecode v7
}

