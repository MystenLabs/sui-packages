module 0x48d4e1028c0e444d7ca36176ce79cc7e092ebccd5107b75c0569e0de13ef701e::flash_liquidate {
    public entry fun liquidate_by_flash_mint<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintConfig, arg4: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x48d4e1028c0e444d7ca36176ce79cc7e092ebccd5107b75c0569e0de13ef701e::liquidate::get_liquidable_debtors<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0), arg1, arg6);
        let v2 = v1;
        assert!(!0x1::vector::is_empty<address>(&v2), 0);
        let (v3, v4) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_mint(arg0, arg3, arg5);
        let v5 = 0x48d4e1028c0e444d7ca36176ce79cc7e092ebccd5107b75c0569e0de13ef701e::liquidate::liquidate_debtors<T0>(arg0, arg1, v2, arg6);
        let (v6, v7, v8) = 0x8487f1ef5dd63f10229957767a08ba519d10ebcb386bb6b5c9ac4b7647db8639::tank::withdraw_all<T0>(arg0, arg1, arg6, arg2, 0x8487f1ef5dd63f10229957767a08ba519d10ebcb386bb6b5c9ac4b7647db8639::tank::deposit<T0>(arg0, v3, arg7), arg7);
        let v9 = v8;
        let v10 = v6;
        let (v11, v12, v13) = 0x8487f1ef5dd63f10229957767a08ba519d10ebcb386bb6b5c9ac4b7647db8639::tank::withdraw_all<T0>(arg0, arg1, arg6, arg2, arg4, arg7);
        0x2::balance::join<T0>(&mut v5, v7);
        0x2::balance::join<T0>(&mut v5, v12);
        0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v10, v11);
        0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(&mut v9, v13);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_burn(arg0, arg3, 0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v10, arg5 + 0), v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v10, arg7), 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg7), 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(v9, arg7), 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

