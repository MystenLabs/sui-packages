module 0xf44ad2cb9bc975cad5babc5ad8a014a64fc1b9e5a09735e2d436b7374e073554::sweep {
    public(friend) fun unsafe_sweep<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>, 0x1::option::Option<0x2::balance::Balance<T0>>, 0x1::option::Option<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>, 0x1::option::Option<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>, u64) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
        let (v1, _, v3) = 0xf44ad2cb9bc975cad5babc5ad8a014a64fc1b9e5a09735e2d436b7374e073554::liquidate::get_liquidable_debtors_with_info<T0>(v0, arg1, arg4);
        let v4 = v3;
        if (0x1::vector::is_empty<address>(&v4)) {
            0xf44ad2cb9bc975cad5babc5ad8a014a64fc1b9e5a09735e2d436b7374e073554::liquidate::emit_lowerst_cr_debtor_info<T0>(v0, arg1, arg4);
            return (0x1::option::none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(), 0x1::option::none<0x2::balance::Balance<T0>>(), 0x1::option::none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(), 0x1::option::none<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>(), 0)
        };
        let (_, _) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg4);
        let v7 = 0x3e90cf9b10c1370c6cb79a359f491755ef6ef4e26c571508f25cbe57c27e8824::info::get_reserve_balance<T0>(arg0);
        let v8 = 0;
        if (v1 > v7) {
            v8 = v1 - v7;
        };
        if (v8 > 0) {
            let (v9, v10) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_mint(arg0, arg3, v8);
            let (v11, v12, v13) = 0xf44ad2cb9bc975cad5babc5ad8a014a64fc1b9e5a09735e2d436b7374e073554::liquidate_with_buck::liquidate_debtors_with_buck<T0>(arg0, arg1, arg2, v4, v9, arg4, arg5);
            return (0x1::option::some<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(v11), 0x1::option::some<0x2::balance::Balance<T0>>(v12), 0x1::option::some<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(v13), 0x1::option::some<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>(v10), v8)
        };
        (0x1::option::none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(), 0x1::option::some<0x2::balance::Balance<T0>>(0xf44ad2cb9bc975cad5babc5ad8a014a64fc1b9e5a09735e2d436b7374e073554::liquidate::liquidate_debtors<T0>(arg0, arg1, v4, arg4)), 0x1::option::none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(), 0x1::option::none<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>(), 0)
    }

    // decompiled from Move bytecode v6
}

