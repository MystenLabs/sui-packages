module 0xd06334a398b476cff8c6ce6bfeb550dd1c054da3935491a5851684ea9aafcd6f::sweep {
    public(friend) fun unsafe_sweep<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>, 0x1::option::Option<0x2::balance::Balance<T0>>, 0x1::option::Option<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>, 0x1::option::Option<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>, u64) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
        let (v1, v2, v3) = 0xd06334a398b476cff8c6ce6bfeb550dd1c054da3935491a5851684ea9aafcd6f::liquidate::get_liquidable_debtors_with_info<T0>(v0, arg1, arg4);
        let v4 = v3;
        if (0x1::vector::is_empty<address>(&v4)) {
            0xd06334a398b476cff8c6ce6bfeb550dd1c054da3935491a5851684ea9aafcd6f::liquidate::emit_lowerst_cr_debtor_info<T0>(v0, arg1, arg4);
            return (0x1::option::none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(), 0x1::option::none<0x2::balance::Balance<T0>>(), 0x1::option::none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(), 0x1::option::none<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>(), 0)
        };
        let (v5, v6) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg4);
        let v7 = 0xdd03647429c161fa9fe0b7cfb7ec76d361c30b71c4c68973a43bf9b133e52141::info::optimize(v1, v2, v5, v6, 0xdd03647429c161fa9fe0b7cfb7ec76d361c30b71c4c68973a43bf9b133e52141::info::get_reserve_balance<T0>(arg0), 500);
        if (v7 > 0) {
            let (v8, v9) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_mint(arg0, arg3, v7);
            let (v10, v11, v12) = 0xd06334a398b476cff8c6ce6bfeb550dd1c054da3935491a5851684ea9aafcd6f::liquidate_with_buck::liquidate_debtors_with_buck<T0>(arg0, arg1, arg2, v4, v8, arg4, arg5);
            return (0x1::option::some<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(v10), 0x1::option::some<0x2::balance::Balance<T0>>(v11), 0x1::option::some<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(v12), 0x1::option::some<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>(v9), v7)
        };
        (0x1::option::none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(), 0x1::option::some<0x2::balance::Balance<T0>>(0xd06334a398b476cff8c6ce6bfeb550dd1c054da3935491a5851684ea9aafcd6f::liquidate::liquidate_debtors<T0>(arg0, arg1, v4, arg4)), 0x1::option::none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(), 0x1::option::none<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>(), 0)
    }

    // decompiled from Move bytecode v6
}

