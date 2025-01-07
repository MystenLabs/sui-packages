module 0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::farm_manager_user {
    public fun add_liquidity<T0, T1, T2>(arg0: &0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::global_config::GlobalConfig, arg1: &mut 0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::farm::Farm, arg2: &mut 0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::position::JewelTurbosPosition, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: vector<0x2::coin::Coin<T0>>, arg6: vector<0x2::coin::Coin<T1>>, arg7: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) {
        0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::global_config::check_package_version(arg0);
        let (v0, v1) = 0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::farm::add_liquidity_with_return<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg12));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg12));
    }

    public fun open_position<T0, T1, T2>(arg0: &0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::global_config::GlobalConfig, arg1: &mut 0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::farm::Farm, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::global_config::check_package_version(arg0);
        let v0 = 0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::position::new(0x2::object::id<0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::farm::Farm>(arg1), 0, arg9);
        let (v1, v2) = 0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::farm::add_liquidity_with_return<T0, T1, T2>(arg1, &mut v0, arg2, arg3, 0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::utils::coin_to_vec<T0>(arg4), 0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::utils::coin_to_vec<T1>(arg5), arg6, 0x2::coin::value<T0>(&arg4), 0x2::coin::value<T1>(&arg5), arg7, arg8, arg9);
        0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::position::transfer_position_and_coins<T0, T1>(v0, v1, v2, 0x2::tx_context::sender(arg9));
    }

    public fun remove_liquidity<T0, T1, T2>(arg0: &0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::global_config::GlobalConfig, arg1: &mut 0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::farm::Farm, arg2: &mut 0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::position::JewelTurbosPosition, arg3: u128, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::global_config::check_package_version(arg0);
        let (v0, v1) = 0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::farm::remove_liquidity_with_return<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg9));
    }

    // decompiled from Move bytecode v6
}

