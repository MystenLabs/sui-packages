module 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::admin {
    public entry fun change_beneficiary(arg0: &0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::AdminCap, arg1: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::Global, arg2: address) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::change_beneficiary(arg1, arg2);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event::emit_change_beneficiary_event(0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::beneficiary(arg1), arg2);
    }

    public entry fun change_beneficiary_profit(arg0: &0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::AdminCap, arg1: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::Global, arg2: u64) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::change_beneficiary_profit(arg1, arg2);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event::emit_change_beneficiary_profit_event(0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::beneficiary_profit(arg1), arg2);
    }

    public entry fun change_swap_fee(arg0: &0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::AdminCap, arg1: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::Global, arg2: u64) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::change_swap_fee(arg1, arg2);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event::emit_change_swap_fee_event(0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::get_swap_fee(arg1), arg2);
    }

    public entry fun collect_fee<T0, T1>(arg0: &0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::AdminCap, arg1: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::Global, arg2: &mut 0x2::tx_context::TxContext) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::check_pause(arg1);
        let (v0, v1, v2, v3) = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::collect_fee<T0, T1>(0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::get_mut_pool<T0, T1>(arg1, 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::is_order<T0, T1>()), arg2);
        let v4 = 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::beneficiary(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v4);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event::emit_collect_fee_event(0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::generate_lp_name<T0, T1>(), v2, v3);
    }

    public entry fun create_admin_cap(arg0: &0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::create_admin_cap(arg1, arg2);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event::emit_create_admin_cap_event(0x2::tx_context::sender(arg2), arg1);
    }

    public entry fun deposit_farm_reward<T0, T1, T2>(arg0: &0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::AdminCap, arg1: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::StakePool<T0, T1, T2>, arg2: 0x2::coin::Coin<T2>, arg3: &0x2::clock::Clock) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::deposit_farm_reward<T0, T1, T2>(0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::is_order<T0, T1>(), arg1, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun enable_emergency<T0, T1, T2>(arg0: &0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::AdminCap, arg1: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::StakePool<T0, T1, T2>, arg2: &0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::Global) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::enable_emergency<T0, T1, T2>(0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::is_order<T0, T1>(), arg1, arg2);
    }

    public entry fun pause(arg0: &0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::AdminCap, arg1: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::Global) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::pause(arg1);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event::emit_pause_event();
    }

    public entry fun register_lp_pool<T0, T1, T2>(arg0: &0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::AdminCap, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: u8, arg4: u8, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::register_lp_pool<T0, T1, T2>(0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::is_order<T0, T1>(), arg1, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5), arg6, arg7, arg8);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event::emit_register_farm_pool_event(0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::generate_lp_name<T0, T1>(), 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::generate_token_name<T2>(), 0x2::coin::value<T2>(&arg1), arg2, arg3, arg4, arg6, arg7);
    }

    public entry fun register_pool<T0, T1>(arg0: &0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::AdminCap, arg1: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::Global, arg2: &mut 0x2::tx_context::TxContext) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::register_pool<T0, T1>(arg1, 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::is_order<T0, T1>());
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event::emit_register_pool_event(0x2::tx_context::sender(arg2), 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::generate_lp_name<T0, T1>());
    }

    public entry fun resume(arg0: &0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::AdminCap, arg1: &mut 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::Global) {
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::core::resume(arg1);
        0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event::emit_resume_event();
    }

    // decompiled from Move bytecode v6
}

