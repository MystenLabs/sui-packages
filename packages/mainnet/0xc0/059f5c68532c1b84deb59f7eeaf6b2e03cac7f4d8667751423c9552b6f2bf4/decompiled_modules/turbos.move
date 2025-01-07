module 0xc0059f5c68532c1b84deb59f7eeaf6b2e03cac7f4d8667751423c9552b6f2bf4::turbos {
    public fun collect_fees<T0: drop, T1: drop, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &0xc0059f5c68532c1b84deb59f7eeaf6b2e03cac7f4d8667751423c9552b6f2bf4::fee::FeeSettings, arg3: &mut 0xc0059f5c68532c1b84deb59f7eeaf6b2e03cac7f4d8667751423c9552b6f2bf4::lock::Lock<T0>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T0, T1, T2>(arg0, arg1, 0xc0059f5c68532c1b84deb59f7eeaf6b2e03cac7f4d8667751423c9552b6f2bf4::lock::borrow_position_mut<T0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg3, arg4), 18446744073709551615, 18446744073709551615, 0x2::tx_context::sender(arg7), 18446744073709551615, arg5, arg6, arg7);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = 0x2::coin::value<T1>(&v2);
        let v6 = 0xc0059f5c68532c1b84deb59f7eeaf6b2e03cac7f4d8667751423c9552b6f2bf4::fee::calculate(arg2, v4);
        let v7 = 0xc0059f5c68532c1b84deb59f7eeaf6b2e03cac7f4d8667751423c9552b6f2bf4::fee::calculate(arg2, v5);
        0xc0059f5c68532c1b84deb59f7eeaf6b2e03cac7f4d8667751423c9552b6f2bf4::lock::add_fee_a<T0>(arg3, v4, v6);
        0xc0059f5c68532c1b84deb59f7eeaf6b2e03cac7f4d8667751423c9552b6f2bf4::lock::add_fee_b<T0>(arg3, v5, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3, v6, arg7), 0xc0059f5c68532c1b84deb59f7eeaf6b2e03cac7f4d8667751423c9552b6f2bf4::fee::recipient(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v2, v7, arg7), 0xc0059f5c68532c1b84deb59f7eeaf6b2e03cac7f4d8667751423c9552b6f2bf4::fee::recipient(arg2));
        (v3, v2)
    }

    public fun lock_liquidity<T0: drop>(arg0: &mut 0xc0059f5c68532c1b84deb59f7eeaf6b2e03cac7f4d8667751423c9552b6f2bf4::lock::Lock<T0>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions) {
        let v0 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg1);
        let (v1, v2, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg2, 0x2::object::id_to_address(&v0));
        0xc0059f5c68532c1b84deb59f7eeaf6b2e03cac7f4d8667751423c9552b6f2bf4::lock::add_position<T0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg1, (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(v1) as u64), (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(v2) as u64));
    }

    public fun unlock_liquidity<T0: drop>(arg0: &mut 0xc0059f5c68532c1b84deb59f7eeaf6b2e03cac7f4d8667751423c9552b6f2bf4::lock::Lock<T0>, arg1: 0x2::object::ID, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x2::tx_context::TxContext) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        let (v0, v1, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg2, 0x2::object::id_to_address(&arg1));
        0xc0059f5c68532c1b84deb59f7eeaf6b2e03cac7f4d8667751423c9552b6f2bf4::lock::remove_position<T0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, arg1, (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(v0) as u64), (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(v1) as u64), arg3)
    }

    // decompiled from Move bytecode v6
}

