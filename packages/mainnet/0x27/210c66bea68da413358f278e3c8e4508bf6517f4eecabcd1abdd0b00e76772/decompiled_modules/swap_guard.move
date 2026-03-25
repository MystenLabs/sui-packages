module 0x1362e9205332d5fd8132772683da18be735b456b97ac86a7115eacb3726c30ad::swap_guard {
    struct SwapVerifiedEvent has copy, drop {
        input_amount: u64,
        output_amount: u64,
        input_decimals: u8,
        output_decimals: u8,
        slippage_bps: u64,
    }

    fun pow10(arg0: u8) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun verify_stable_swap(arg0: &0x1362e9205332d5fd8132772683da18be735b456b97ac86a7115eacb3726c30ad::crank::CrankConfig, arg1: u64, arg2: u64, arg3: u8, arg4: u8) {
        assert!(arg1 > 0, 1002);
        assert!(arg3 <= 18 && arg4 <= 18, 1001);
        let v0 = (arg1 as u128) * pow10(arg4);
        let v1 = (arg2 as u128) * pow10(arg3);
        assert!(v1 >= v0 * (10000 - (0x1362e9205332d5fd8132772683da18be735b456b97ac86a7115eacb3726c30ad::crank::max_swap_slippage_bps(arg0) as u128)) / 10000, 1000);
        let v2 = if (v1 >= v0) {
            0
        } else {
            (((v0 - v1) * 10000 / v0) as u64)
        };
        let v3 = SwapVerifiedEvent{
            input_amount    : arg1,
            output_amount   : arg2,
            input_decimals  : arg3,
            output_decimals : arg4,
            slippage_bps    : v2,
        };
        0x2::event::emit<SwapVerifiedEvent>(v3);
    }

    public fun verify_usdc_to_usdsui(arg0: &0x1362e9205332d5fd8132772683da18be735b456b97ac86a7115eacb3726c30ad::crank::CrankConfig, arg1: u64, arg2: u64) {
        verify_stable_swap(arg0, arg1, arg2, 6, 9);
    }

    public fun verify_usdsui_to_usdc(arg0: &0x1362e9205332d5fd8132772683da18be735b456b97ac86a7115eacb3726c30ad::crank::CrankConfig, arg1: u64, arg2: u64) {
        verify_stable_swap(arg0, arg1, arg2, 9, 6);
    }

    // decompiled from Move bytecode v6
}

