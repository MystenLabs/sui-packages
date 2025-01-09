module 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::farm_manager_user {
    public fun add_liquidity<T0, T1, T2>(arg0: &0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::global_config::GlobalConfig, arg1: &mut 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::farm::Farm, arg2: &mut 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::position::JewelTurbosPosition, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: &mut 0x2::tx_context::TxContext) {
        0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::global_config::check_package_version(arg0);
        let (v0, v1) = 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::farm::add_liquidity_with_return<T0, T1, T2>(arg1, arg2, arg3, arg4, 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::utils::coin_to_vec<T0>(arg5), 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::utils::coin_to_vec<T1>(arg6), 0x2::coin::value<T0>(&arg5), 0x2::coin::value<T1>(&arg6), arg7, arg8, arg9, arg10, arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg11));
    }

    public fun close_position(arg0: &0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::global_config::GlobalConfig, arg1: 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::position::JewelTurbosPosition) {
        0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::global_config::check_package_version(arg0);
        0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::position::destroy(arg1);
    }

    public fun merge_positions(arg0: &0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::global_config::GlobalConfig, arg1: &mut 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::position::JewelTurbosPosition, arg2: 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::position::JewelTurbosPosition) {
        0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::global_config::check_package_version(arg0);
        0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::position::merge(arg1, arg2);
    }

    public fun open_position<T0, T1, T2>(arg0: &0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::global_config::GlobalConfig, arg1: &mut 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::farm::Farm, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::global_config::check_package_version(arg0);
        let v0 = 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::position::new(0x2::object::id<0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::farm::Farm>(arg1), 0, arg10);
        let (v1, v2) = 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::farm::add_liquidity_with_return<T0, T1, T2>(arg1, &mut v0, arg2, arg3, 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::utils::coin_to_vec<T0>(arg4), 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::utils::coin_to_vec<T1>(arg5), 0x2::coin::value<T0>(&arg4), 0x2::coin::value<T1>(&arg5), arg6, arg7, arg8, arg9, arg10);
        0x2::transfer::public_transfer<0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::position::JewelTurbosPosition>(v0, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg10));
    }

    public fun remove_liquidity<T0, T1, T2>(arg0: &0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::global_config::GlobalConfig, arg1: &mut 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::farm::Farm, arg2: &mut 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::position::JewelTurbosPosition, arg3: u128, arg4: u64, arg5: u64, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg7: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::global_config::check_package_version(arg0);
        let (v0, v1) = 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::farm::remove_liquidity_with_return<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg10));
    }

    // decompiled from Move bytecode v6
}

