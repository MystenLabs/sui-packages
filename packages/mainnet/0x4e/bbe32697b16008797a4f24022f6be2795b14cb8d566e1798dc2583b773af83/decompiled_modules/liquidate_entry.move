module 0x4ebbe32697b16008797a4f24022f6be2795b14cb8d566e1798dc2583b773af83::liquidate_entry {
    public entry fun liquidate_by_saving_pool<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg3: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg5: vector<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
        let (_, v2) = 0x4ebbe32697b16008797a4f24022f6be2795b14cb8d566e1798dc2583b773af83::liquidate::get_liquidable_debtors<T0>(v0, arg1, arg6);
        let v3 = v2;
        if (0x1::vector::is_empty<address>(&v3)) {
            let v4 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_lowest_cr_debtor<T0>(v0);
            if (0x1::option::is_some<address>(&v4)) {
                0x4ebbe32697b16008797a4f24022f6be2795b14cb8d566e1798dc2583b773af83::liquidate::emit_debtor_info<T0>(v0, arg1, 0x1::option::destroy_some<address>(v4), arg6);
            };
        };
        let (v5, v6) = 0x8487f1ef5dd63f10229957767a08ba519d10ebcb386bb6b5c9ac4b7647db8639::sbuck::withdraw_all_buck(arg3, arg4, arg5, arg6, arg7);
        let v7 = 0x4ebbe32697b16008797a4f24022f6be2795b14cb8d566e1798dc2583b773af83::liquidate::liquidate_debtors<T0>(arg0, arg1, v3, arg6);
        let (v8, v9, v10) = 0x8487f1ef5dd63f10229957767a08ba519d10ebcb386bb6b5c9ac4b7647db8639::tank::withdraw_all<T0>(arg0, arg1, arg6, arg2, 0x8487f1ef5dd63f10229957767a08ba519d10ebcb386bb6b5c9ac4b7647db8639::tank::deposit<T0>(arg0, v5, arg7), arg7);
        0x2::balance::join<T0>(&mut v7, v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg7), 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg7), 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(v10, arg7), 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(0x8487f1ef5dd63f10229957767a08ba519d10ebcb386bb6b5c9ac4b7647db8639::sbuck::deposit_buck(arg3, arg4, 0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v8, arg7), arg6, arg7), 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

