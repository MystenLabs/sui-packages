module 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::adapter_turbos {
    public fun add_liquidity<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        (0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_turbos::add_liquidity<T0, T1, T2>(arg0, arg1, arg2, &mut arg3, &mut arg4, 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::to_open_params(arg5), arg6, arg7), arg3, arg4)
    }

    public fun close_position<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_turbos::burn_position<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun collect_reward<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg4: u64, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_turbos::collect_reward<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg6, arg5, arg7)
    }

    public fun trader_add_liquidity<T0, T1, T2>(arg0: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::Account, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::add_position<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_turbos::add_liquidity<T0, T1, T2>(arg1, arg2, arg3, &mut arg4, &mut arg5, 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::to_open_params(arg6), arg7, arg8), arg8);
        let v0 = 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::get_info(arg0);
        let v1 = 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::account_recipient(&v0);
        if (0x2::coin::value<T0>(&arg4) > 0) {
            0x2::coin::send_funds<T0>(arg4, v1);
        } else {
            0x2::coin::destroy_zero<T0>(arg4);
        };
        if (0x2::coin::value<T1>(&arg5) > 0) {
            0x2::coin::send_funds<T1>(arg5, v1);
        } else {
            0x2::coin::destroy_zero<T1>(arg5);
        };
    }

    public fun trader_close_position<T0, T1, T2>(arg0: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::Account, arg1: 0x2::object::ID, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::get_info(arg0);
        let v1 = 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::account_recipient(&v0);
        let (v2, v3) = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_turbos::burn_position<T0, T1, T2>(arg2, arg3, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::take_position<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg1, arg6), arg5, arg4, arg6);
        let v4 = v3;
        let v5 = v2;
        if (0x2::coin::value<T0>(&v5) > 0) {
            0x2::coin::send_funds<T0>(v5, v1);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
        if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::send_funds<T1>(v4, v1);
        } else {
            0x2::coin::destroy_zero<T1>(v4);
        };
    }

    public fun trader_collect_reward<T0, T1, T2, T3>(arg0: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::Account, arg1: 0x2::object::ID, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg5: u64, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_turbos::collect_reward<T0, T1, T2, T3>(arg2, arg3, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::borrow_mut_position<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg1, arg8), arg4, arg5, arg7, arg6, arg8);
        if (0x2::coin::value<T3>(&v0) > 0) {
            let v1 = 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::get_info(arg0);
            0x2::coin::send_funds<T3>(v0, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::account_recipient(&v1));
        } else {
            0x2::coin::destroy_zero<T3>(v0);
        };
    }

    public fun vault_add_liquidity<T0, T1, T2>(arg0: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::Account, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T0>, arg5: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T1>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::withdraw_coins<T0>(arg0, arg4, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::vault_balance<T0>(arg4), arg8);
        let v1 = 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::withdraw_coins<T1>(arg0, arg5, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::vault_balance<T1>(arg5), arg8);
        0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::add_position<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_turbos::add_liquidity<T0, T1, T2>(arg1, arg2, arg3, &mut v0, &mut v1, 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::to_open_params(arg6), arg7, arg8), arg8);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::deposit<T0>(arg4, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        if (0x2::coin::value<T1>(&v1) > 0) {
            0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::deposit<T1>(arg5, v1);
        } else {
            0x2::coin::destroy_zero<T1>(v1);
        };
    }

    public fun vault_close_position<T0, T1, T2>(arg0: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::Account, arg1: 0x2::object::ID, arg2: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T0>, arg3: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_turbos::burn_position<T0, T1, T2>(arg4, arg5, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::take_position<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg1, arg8), arg7, arg6, arg8);
        let v2 = v1;
        let v3 = v0;
        if (0x2::coin::value<T0>(&v3) > 0) {
            0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::deposit<T0>(arg2, v3);
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        if (0x2::coin::value<T1>(&v2) > 0) {
            0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::deposit<T1>(arg3, v2);
        } else {
            0x2::coin::destroy_zero<T1>(v2);
        };
    }

    public fun vault_collect_reward<T0, T1, T2, T3>(arg0: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::Account, arg1: 0x2::object::ID, arg2: &mut 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::Vault<T3>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg6: u64, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_turbos::collect_reward<T0, T1, T2, T3>(arg3, arg4, 0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::account::borrow_mut_position<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg1, arg9), arg5, arg6, arg8, arg7, arg9);
        if (0x2::coin::value<T3>(&v0) > 0) {
            0x37aab523b440d8c28eee8e71ba5b3ef32d5d582439d42fe6c42fb56996668138::vault::deposit<T3>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<T3>(v0);
        };
    }

    // decompiled from Move bytecode v7
}

