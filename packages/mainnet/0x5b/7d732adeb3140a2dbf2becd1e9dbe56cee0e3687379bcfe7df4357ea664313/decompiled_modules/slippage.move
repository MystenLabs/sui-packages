module 0x88dfe5e893bc9fa984d121e4d0d5b2e873dc70ae430cf5b3228ae6cb199cb32b::slippage {
    struct SwapEvent<phantom T0, phantom T1> has copy, drop {
        amount_in: u64,
        amount_out: u64,
        min_amount_out: u64,
        referral_code: u64,
    }

    struct SwapWithReferralEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        swap_initializer_address: address,
        receiver_address: address,
        from_coin_price: u64,
        from_coin_amount: u64,
        to_coin_price: u64,
        to_coin_amount: u64,
        reward_amount: u64,
        rewards_ratio: u64,
        referral_id: u64,
    }

    struct ExSwapWithReferralEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        swap_initializer_address: address,
        receiver_address: address,
        from_coin_price: u64,
        from_coin_amount: u128,
        to_coin_price: u64,
        to_coin_amount: u128,
        reward_amount: u128,
        rewards_ratio: u64,
        referral_id: u64,
    }

    public fun check_slippage_v2<T0, T1>(arg0: &0x2::coin::Coin<T1>, arg1: u64, arg2: u64, arg3: u64) {
        assert!(0x2::coin::value<T1>(arg0) >= arg1, 10001);
        let v0 = SwapEvent<T0, T1>{
            amount_in      : arg2,
            amount_out     : 0x2::coin::value<T1>(arg0),
            min_amount_out : arg1,
            referral_code  : arg3,
        };
        0x2::event::emit<SwapEvent<T0, T1>>(v0);
    }

    fun convert_amount(arg0: u64, arg1: u8, arg2: u8) : u64 {
        while (arg1 != arg2) {
            if (arg1 < arg2) {
                arg0 = arg0 * 10;
                arg1 = arg1 + 1;
                continue
            };
            arg0 = arg0 / 10;
            arg1 = arg1 - 1;
        };
        arg0
    }

    public fun emit_referral_event<T0, T1, T2>(arg0: &0x2::coin::Coin<T1>, arg1: &0x2::coin::Coin<T2>, arg2: address, arg3: u8, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::tx_context::TxContext) {
        let v0 = ExSwapWithReferralEvent<T0, T1, T2>{
            swap_initializer_address : 0x2::tx_context::sender(arg11),
            receiver_address         : arg2,
            from_coin_price          : arg7,
            from_coin_amount         : ex_convert_amount((arg6 as u128), arg3, 9),
            to_coin_price            : arg8,
            to_coin_amount           : ex_convert_amount((0x2::coin::value<T1>(arg0) as u128), arg4, 9),
            reward_amount            : ex_convert_amount((0x2::coin::value<T2>(arg1) as u128), arg5, 9),
            rewards_ratio            : arg9,
            referral_id              : arg10,
        };
        0x2::event::emit<ExSwapWithReferralEvent<T0, T1, T2>>(v0);
    }

    fun ex_convert_amount(arg0: u128, arg1: u8, arg2: u8) : u128 {
        while (arg1 != arg2) {
            if (arg1 < arg2) {
                arg0 = arg0 * 10;
                arg1 = arg1 + 1;
                continue
            };
            arg0 = arg0 / 10;
            arg1 = arg1 - 1;
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

