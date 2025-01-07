module 0xf62aac48a71ce3b52f67a1733a11d6a0d2a8464c336e0415fabd3d682167a6ae::liquidate_entry {
    public entry fun liquidate_by_saving_pool<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg3: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg5: vector<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
        let v1 = 0xf62aac48a71ce3b52f67a1733a11d6a0d2a8464c336e0415fabd3d682167a6ae::liquidate::get_liquidable_debtors<T0>(v0, arg1, arg6);
        if (0x1::vector::is_empty<address>(&v1)) {
            0xf62aac48a71ce3b52f67a1733a11d6a0d2a8464c336e0415fabd3d682167a6ae::liquidate::emit_lowerst_cr_debtor_info<T0>(v0, arg1, arg6);
        };
        let (v2, v3) = 0x7b8ecd493df6ac261faf0ab779e1179716949d276d96f8692bc3fe0aef30c715::sbuck::withdraw_all_buck(arg3, arg4, arg5, arg6, arg7);
        let v4 = 0xf62aac48a71ce3b52f67a1733a11d6a0d2a8464c336e0415fabd3d682167a6ae::liquidate::liquidate_debtors<T0>(arg0, arg1, v1, arg6);
        let (v5, v6, v7) = 0x7b8ecd493df6ac261faf0ab779e1179716949d276d96f8692bc3fe0aef30c715::tank::withdraw_all<T0>(arg0, arg1, arg6, arg2, 0x7b8ecd493df6ac261faf0ab779e1179716949d276d96f8692bc3fe0aef30c715::tank::deposit<T0>(arg0, v2, arg7), arg7);
        0x2::balance::join<T0>(&mut v4, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg7), 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg7), 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(v7, arg7), 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(0x7b8ecd493df6ac261faf0ab779e1179716949d276d96f8692bc3fe0aef30c715::sbuck::deposit_buck(arg3, arg4, 0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v5, arg7), arg6, arg7), 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

