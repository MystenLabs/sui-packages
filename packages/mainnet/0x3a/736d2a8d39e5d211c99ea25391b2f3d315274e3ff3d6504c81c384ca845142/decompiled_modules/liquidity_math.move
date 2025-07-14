module 0x7d281a9cb846a367384e0dd1e944ad67d4d4fb33615096d7bb261b0103ed837c::liquidity_math {
    public(friend) fun liquidity_for_amounts(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : u128 {
        if (arg0 <= arg1) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_liquidity_from_a(arg1, arg2, arg3, false)
        } else if (arg0 >= arg2) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_liquidity_from_b(arg1, arg2, arg4, false)
        } else {
            0x1::u128::min(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_liquidity_from_a(arg0, arg2, arg3, false), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_liquidity_from_b(arg1, arg0, arg4, false))
        }
    }

    // decompiled from Move bytecode v6
}

