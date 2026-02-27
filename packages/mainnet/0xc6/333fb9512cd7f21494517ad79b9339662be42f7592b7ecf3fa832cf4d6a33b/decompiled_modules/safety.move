module 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::safety {
    struct LargeTransactionAlert has copy, drop {
        user: address,
        amount: u64,
        total_assets: u64,
        threshold_bps: u64,
        timestamp: u64,
    }

    struct RateLimitTriggered has copy, drop {
        user: address,
        action_count: u64,
        window_ms: u64,
        timestamp: u64,
    }

    public fun batch_withdraw_safety_check<T0>(arg0: &0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::Vault<T0>, arg1: &0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::admin::Config, arg2: u64, arg3: &0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::UserPosition, arg4: &mut 0x2::tx_context::TxContext) {
        withdraw_safety_check<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    fun calculate_assets(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0 || arg1 == 0) {
            return arg0
        };
        arg0 * arg1 / arg2
    }

    public fun calculate_min_receive(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        calculate_assets(arg0, arg1, arg2) * (10000 - arg3) / 10000
    }

    public fun check_large_transaction(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            return
        };
        if (arg1 > arg2 * arg3 / 10000) {
            let v0 = LargeTransactionAlert{
                user          : arg0,
                amount        : arg1,
                total_assets  : arg2,
                threshold_bps : arg3,
                timestamp     : 0x2::tx_context::epoch_timestamp_ms(arg4),
            };
            0x2::event::emit<LargeTransactionAlert>(v0);
        };
    }

    public fun check_rate_limit(arg0: &0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::admin::Config, arg1: &0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::UserPosition, arg2: &mut 0x2::tx_context::TxContext) {
    }

    public fun check_slippage(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 307);
    }

    public fun deposit_safety_check<T0>(arg0: &0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::Vault<T0>, arg1: &0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::admin::Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::admin::is_paused(arg1), 301);
        assert!(arg2 >= 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::admin::get_min_deposit(arg1), 302);
        let v0 = 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::admin::get_max_deposit(arg1);
        if (v0 > 0) {
            assert!(arg2 <= v0, 304);
        };
        verify_token<T0>(arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        check_large_transaction(v1, arg2, 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::get_total_assets<T0>(arg0), 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::admin::get_large_tx_threshold(arg1), arg3);
    }

    public fun verify_token<T0>(arg0: &0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::Vault<T0>) {
        assert!(0x1::type_name::with_defining_ids<T0>() == 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::get_wusdc_type<T0>(arg0), 300);
    }

    public fun withdraw_safety_check<T0>(arg0: &0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::Vault<T0>, arg1: &0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::admin::Config, arg2: u64, arg3: &0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::UserPosition, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::get_shares(arg3) >= arg2, 303);
        let v0 = 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::admin::get_max_withdraw(arg1);
        if (v0 > 0) {
            assert!(calculate_assets(arg2, 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::get_total_assets<T0>(arg0), 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::vault::get_total_shares<T0>(arg0)) <= v0, 305);
        };
    }

    // decompiled from Move bytecode v6
}

