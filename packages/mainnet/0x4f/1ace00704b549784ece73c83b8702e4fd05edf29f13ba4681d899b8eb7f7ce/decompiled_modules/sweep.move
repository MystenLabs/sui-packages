module 0x4f1ace00704b549784ece73c83b8702e4fd05edf29f13ba4681d899b8eb7f7ce::sweep {
    public fun clear(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintConfig, arg2: 0x1::option::Option<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>, arg3: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: 0x1::option::Option<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>, arg5: 0x1::option::Option<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(&arg2)) {
            0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut arg3, 0x1::option::destroy_some<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(arg2));
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(arg2);
        };
        if (0x1::option::is_some<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(&arg4)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(0x1::option::destroy_some<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(arg4), arg7), @0xed3c50e9137b1263db5005e11256d288856d4387befa0433b69045f6d53fae68);
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(arg4);
        };
        if (0x1::option::is_some<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>(&arg5)) {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_burn(arg0, arg1, 0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut arg3, arg6 + 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg6, 500, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::fee_precision())), 0x1::option::destroy_some<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>(arg5));
        } else {
            0x1::option::destroy_none<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>(arg5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg3, arg7), @0xed3c50e9137b1263db5005e11256d288856d4387befa0433b69045f6d53fae68);
    }

    public fun unsafe_liquidate<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>, 0x2::balance::Balance<T0>, 0x1::option::Option<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>, 0x1::option::Option<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>, u64) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
        let (v1, _, v3) = 0x4f1ace00704b549784ece73c83b8702e4fd05edf29f13ba4681d899b8eb7f7ce::liquidate::get_liquidable_debtors_with_info<T0>(v0, arg1, arg4);
        let v4 = v3;
        if (0x1::vector::is_empty<address>(&v4)) {
            0x4f1ace00704b549784ece73c83b8702e4fd05edf29f13ba4681d899b8eb7f7ce::liquidate::emit_lowerst_cr_debtor_info<T0>(v0, arg1, arg4);
            return (0x1::option::none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(), 0x2::balance::zero<T0>(), 0x1::option::none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(), 0x1::option::none<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>(), 0)
        };
        let (_, _) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg4);
        let v7 = 0xc5ca930eaeb2f2ef5773058ce7c8edd2f7a796d929833e81daeda1b796044960::info::get_reserve_balance<T0>(arg0);
        let v8 = 0;
        if (v1 > v7) {
            v8 = v1 - v7;
        };
        if (v8 > 0) {
            let (v9, v10) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_mint(arg0, arg3, v8);
            let (v11, v12, v13) = 0x4f1ace00704b549784ece73c83b8702e4fd05edf29f13ba4681d899b8eb7f7ce::liquidate_with_buck::liquidate_debtors_with_buck<T0>(arg0, arg1, arg2, v4, v9, arg4, arg5);
            return (0x1::option::some<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(v11), v12, 0x1::option::some<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(v13), 0x1::option::some<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>(v10), v8)
        };
        (0x1::option::none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(), 0x4f1ace00704b549784ece73c83b8702e4fd05edf29f13ba4681d899b8eb7f7ce::liquidate::liquidate_debtors<T0>(arg0, arg1, v4, arg4), 0x1::option::none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(), 0x1::option::none<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>(), 0)
    }

    public(friend) fun unsafe_sweep<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>, 0x1::option::Option<0x2::balance::Balance<T0>>, 0x1::option::Option<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>, 0x1::option::Option<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>, u64) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
        let (v1, _, v3) = 0x4f1ace00704b549784ece73c83b8702e4fd05edf29f13ba4681d899b8eb7f7ce::liquidate::get_liquidable_debtors_with_info<T0>(v0, arg1, arg4);
        let v4 = v3;
        if (0x1::vector::is_empty<address>(&v4)) {
            0x4f1ace00704b549784ece73c83b8702e4fd05edf29f13ba4681d899b8eb7f7ce::liquidate::emit_lowerst_cr_debtor_info<T0>(v0, arg1, arg4);
            return (0x1::option::none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(), 0x1::option::none<0x2::balance::Balance<T0>>(), 0x1::option::none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(), 0x1::option::none<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>(), 0)
        };
        let (_, _) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg4);
        let v7 = 0xc5ca930eaeb2f2ef5773058ce7c8edd2f7a796d929833e81daeda1b796044960::info::get_reserve_balance<T0>(arg0);
        let v8 = 0;
        if (v1 > v7) {
            v8 = v1 - v7;
        };
        if (v8 > 0) {
            let (v9, v10) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_mint(arg0, arg3, v8);
            let (v11, v12, v13) = 0x4f1ace00704b549784ece73c83b8702e4fd05edf29f13ba4681d899b8eb7f7ce::liquidate_with_buck::liquidate_debtors_with_buck<T0>(arg0, arg1, arg2, v4, v9, arg4, arg5);
            return (0x1::option::some<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(v11), 0x1::option::some<0x2::balance::Balance<T0>>(v12), 0x1::option::some<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(v13), 0x1::option::some<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>(v10), v8)
        };
        (0x1::option::none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(), 0x1::option::some<0x2::balance::Balance<T0>>(0x4f1ace00704b549784ece73c83b8702e4fd05edf29f13ba4681d899b8eb7f7ce::liquidate::liquidate_debtors<T0>(arg0, arg1, v4, arg4)), 0x1::option::none<0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(), 0x1::option::none<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintReceipt>(), 0)
    }

    // decompiled from Move bytecode v6
}

