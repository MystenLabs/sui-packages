module 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::turbos {
    public fun collect<T0: drop, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::fee::FeeSettings, arg3: &mut 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::lock::Lock<T0>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T1, T2, T3>(arg0, arg1, 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::lock::borrow_position_mut<T0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg3, arg4), 18446744073709551615, 18446744073709551615, 0x2::tx_context::sender(arg7), 18446744073709551615, arg5, arg6, arg7);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::coin::value<T1>(&v3);
        let v5 = 0x2::coin::value<T2>(&v2);
        let v6 = 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::fee::calculate(arg2, v4);
        let v7 = 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::fee::calculate(arg2, v5);
        0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::lock::add_fee_a<T0>(arg3, v4, v6);
        0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::lock::add_fee_b<T0>(arg3, v5, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v3, v6, arg7), 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::fee::recipient(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::split<T2>(&mut v2, v7, arg7), 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::fee::recipient(arg2));
        (v3, v2)
    }

    public fun lock_liquidity<T0: drop>(arg0: &mut 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::lock::Lock<T0>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions) {
        let v0 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg1);
        let (v1, v2, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg2, 0x2::object::id_to_address(&v0));
        0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::lock::add_position<T0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg1, (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(v1) as u64), (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(v2) as u64));
    }

    public fun unlock_liquidity<T0: drop>(arg0: &mut 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::lock::Lock<T0>, arg1: 0x2::object::ID, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x2::tx_context::TxContext) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        let (v0, v1, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg2, 0x2::object::id_to_address(&arg1));
        0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::lock::remove_position<T0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg1, (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(v0) as u64), (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(v1) as u64), arg3)
    }

    // decompiled from Move bytecode v6
}

