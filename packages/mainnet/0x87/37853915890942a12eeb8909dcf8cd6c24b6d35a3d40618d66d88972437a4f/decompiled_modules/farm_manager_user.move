module 0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::farm_manager_user {
    public fun add_liquidity<T0, T1, T2>(arg0: &0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::global_config::GlobalConfig, arg1: &mut 0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::farm::Farm, arg2: &mut 0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::position::JewelTurbosPosition, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: &mut 0x2::tx_context::TxContext) {
        0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::global_config::check_package_version(arg0);
        let (v0, v1) = 0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::farm::add_liquidity_with_return<T0, T1, T2>(arg1, arg2, arg3, arg4, 0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::utils::coin_to_vec<T0>(arg5), 0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::utils::coin_to_vec<T1>(arg6), 0x2::coin::value<T0>(&arg5), 0x2::coin::value<T1>(&arg6), arg7, arg8, arg9, arg10, arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg11));
    }

    public fun close_position(arg0: &0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::global_config::GlobalConfig, arg1: 0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::position::JewelTurbosPosition) {
        0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::global_config::check_package_version(arg0);
        0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::position::destroy(arg1);
    }

    public fun merge_positions(arg0: &0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::global_config::GlobalConfig, arg1: &mut 0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::position::JewelTurbosPosition, arg2: 0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::position::JewelTurbosPosition) {
        0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::global_config::check_package_version(arg0);
        0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::position::merge(arg1, arg2);
    }

    public fun open_position<T0, T1, T2>(arg0: &0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::global_config::GlobalConfig, arg1: &mut 0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::farm::Farm, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::global_config::check_package_version(arg0);
        let v0 = 0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::position::new(0x2::object::id<0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::farm::Farm>(arg1), 0, arg10);
        let (v1, v2) = 0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::farm::add_liquidity_with_return<T0, T1, T2>(arg1, &mut v0, arg2, arg3, 0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::utils::coin_to_vec<T0>(arg4), 0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::utils::coin_to_vec<T1>(arg5), 0x2::coin::value<T0>(&arg4), 0x2::coin::value<T1>(&arg5), arg6, arg7, arg8, arg9, arg10);
        0x2::transfer::public_transfer<0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::position::JewelTurbosPosition>(v0, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg10));
    }

    public fun remove_liquidity<T0, T1, T2>(arg0: &0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::global_config::GlobalConfig, arg1: &mut 0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::farm::Farm, arg2: &mut 0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::position::JewelTurbosPosition, arg3: u128, arg4: u64, arg5: u64, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg7: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::global_config::check_package_version(arg0);
        let (v0, v1) = 0xfa137372a9ecaf25fbd15e02fd0466baa73b71221f9eadf466c285ba4d85d0b5::farm::remove_liquidity_with_return<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg10));
    }

    // decompiled from Move bytecode v6
}

