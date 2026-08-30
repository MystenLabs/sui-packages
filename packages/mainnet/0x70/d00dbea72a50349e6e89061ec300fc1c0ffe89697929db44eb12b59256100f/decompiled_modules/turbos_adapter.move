module 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::turbos_adapter {
    public fun close_position<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg3: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg4: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T1>, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::module_turbos::burn_position<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun collect_reward<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg4: u64, arg5: &0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::TraderAccount, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::module_turbos::collect_reward_account<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun collect_reward_v<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg4: u64, arg5: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T3>, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::module_turbos::collect_reward_vault<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun open_position<T0, T1, T2>(arg0: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::TraderAccount, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg5: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T1>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::module_turbos::add_liquidity<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::type_params::to_open_params(arg6), arg7, arg8);
    }

    // decompiled from Move bytecode v7
}

