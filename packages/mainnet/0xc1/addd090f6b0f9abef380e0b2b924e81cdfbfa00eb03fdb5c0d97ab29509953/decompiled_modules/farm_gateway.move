module 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::farm_gateway {
    public fun active_liquidity<T0, T1>(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::Pool<T0, T1>) : u128 {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::farm_active_liquidity<T0, T1>(arg0)
    }

    public entry fun create_farm<T0, T1, T2>(arg0: &mut 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: &mut 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: 0x1::string::String, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::create_farm<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun harvest<T0, T1, T2>(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: &mut 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::Pool<T0, T1>, arg2: &mut 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::farm::StakedPosition, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::transfer_balance<T2>(0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::harvest_farm_rewards<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public fun has_staked_position<T0, T1>(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::Pool<T0, T1>, arg1: 0x2::object::ID) : bool {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::has_staked_farm_position<T0, T1>(arg0, arg1)
    }

    public entry fun pause<T0, T1>(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: &mut 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::update_farm_pause_status<T0, T1>(arg0, arg1, true, arg2, arg3);
    }

    public fun pending_rewards<T0, T1, T2>(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::Pool<T0, T1>, arg1: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::farm::StakedPosition, arg2: u64) : u64 {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::pending_farm_rewards<T0, T1, T2>(arg0, arg1, arg2)
    }

    public entry fun refund_unallocated_rewards<T0, T1, T2>(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: &mut 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::Pool<T0, T1>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::transfer_balance<T2>(0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::refund_unallocated_farm_rewards<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4), arg2, arg4);
    }

    public entry fun resume<T0, T1>(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: &mut 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::update_farm_pause_status<T0, T1>(arg0, arg1, false, arg2, arg3);
    }

    public entry fun stake_position<T0, T1>(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: &mut 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::Pool<T0, T1>, arg2: 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::transfer_staked_farm_position(0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::stake_farm_position<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun top_up_rewards<T0, T1, T2>(arg0: &mut 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: &mut 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::top_up_farm_rewards<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun unstake_position<T0, T1, T2>(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: &mut 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::Pool<T0, T1>, arg2: 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::farm::StakedPosition, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::pool::unstake_farm_position<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::position::Position>(v0, 0x2::tx_context::sender(arg4));
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::transfer_balance<T2>(v1, 0x2::tx_context::sender(arg4), arg4);
    }

    // decompiled from Move bytecode v7
}

