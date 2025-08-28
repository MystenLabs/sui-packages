module 0xae7543cc09062bfca91ac0d33da7d44b2df1659d84cee87489979a05d66fc41d::staked_position_script {
    public fun add_staked_liquidity_by_fix_coin<T0, T1, T2, T3>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::distribution_config::DistributionConfig, arg2: &mut 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::minter::Minter<T2>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg5: &mut 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::gauge::Gauge<T0, T1>, arg6: 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::gauge::StakedPosition, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::gauge::StakedPosition {
        let v0 = 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::minter::get_position_reward<T0, T1, T2, T3>(arg2, arg1, arg5, arg4, &arg6, arg12, arg13);
        if (0x2::coin::value<T3>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v0, 0x2::tx_context::sender(arg13));
        } else {
            0x2::coin::destroy_zero<T3>(v0);
        };
        let v1 = 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::gauge::withdraw_position<T0, T1>(arg5, arg1, arg4, arg6, arg12, arg13);
        0xae7543cc09062bfca91ac0d33da7d44b2df1659d84cee87489979a05d66fc41d::pool_script_v2::add_liquidity_by_fix_coin<T0, T1>(arg0, arg3, arg4, &mut v1, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::gauge::deposit_position<T0, T1>(arg0, arg1, arg5, arg4, v1, arg12, arg13)
    }

    public fun close_staked_position<T0, T1, T2, T3>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::distribution_config::DistributionConfig, arg2: &mut 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::minter::Minter<T2>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg5: &mut 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::gauge::Gauge<T0, T1>, arg6: 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::gauge::StakedPosition, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::minter::get_position_reward<T0, T1, T2, T3>(arg2, arg1, arg5, arg4, &arg6, arg9, arg10);
        if (0x2::coin::value<T3>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v0, 0x2::tx_context::sender(arg10));
        } else {
            0x2::coin::destroy_zero<T3>(v0);
        };
        0xae7543cc09062bfca91ac0d33da7d44b2df1659d84cee87489979a05d66fc41d::pool_script_v2::close_position<T0, T1>(arg0, arg3, arg4, 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::gauge::withdraw_position<T0, T1>(arg5, arg1, arg4, arg6, arg9, arg10), arg7, arg8, arg9, arg10);
    }

    public fun open_position_and_stake_with_liquidity_by_fix_coin<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::distribution_config::DistributionConfig, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg4: &mut 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::gauge::Gauge<T0, T1>, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::gauge::StakedPosition {
        0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::gauge::deposit_position<T0, T1>(arg0, arg1, arg4, arg3, 0xae7543cc09062bfca91ac0d33da7d44b2df1659d84cee87489979a05d66fc41d::pool_script_v2::open_position_with_liquidity_by_fix_coin_return<T0, T1>(arg0, arg2, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13), arg12, arg13)
    }

    public fun remove_staked_liquidity_by_fix_coin<T0, T1, T2, T3>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::distribution_config::DistributionConfig, arg2: &mut 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::minter::Minter<T2>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg5: &mut 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::gauge::Gauge<T0, T1>, arg6: 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::gauge::StakedPosition, arg7: u128, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::gauge::StakedPosition {
        let v0 = 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::minter::get_position_reward<T0, T1, T2, T3>(arg2, arg1, arg5, arg4, &arg6, arg10, arg11);
        if (0x2::coin::value<T3>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v0, 0x2::tx_context::sender(arg11));
        } else {
            0x2::coin::destroy_zero<T3>(v0);
        };
        let v1 = 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::gauge::withdraw_position<T0, T1>(arg5, arg1, arg4, arg6, arg10, arg11);
        0xae7543cc09062bfca91ac0d33da7d44b2df1659d84cee87489979a05d66fc41d::pool_script_v2::remove_liquidity<T0, T1>(arg0, arg3, arg4, &mut v1, arg7, arg8, arg9, arg10, arg11);
        0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::gauge::deposit_position<T0, T1>(arg0, arg1, arg5, arg4, v1, arg10, arg11)
    }

    // decompiled from Move bytecode v6
}

