module 0xbb2a79cc8c35256bb8017f5a6d4ed6706ff62dea642ab37b118a00d81bef2af::flash_liquidate_by_cetus {
    public entry fun unsafe_flash_liquidate_xsui<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintConfig, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
        let (_, v2) = 0xbb2a79cc8c35256bb8017f5a6d4ed6706ff62dea642ab37b118a00d81bef2af::liquidate::get_liquidable_debtors<T0>(v0, arg1, arg9);
        let v3 = v2;
        if (0x1::vector::is_empty<address>(&v3)) {
            0xbb2a79cc8c35256bb8017f5a6d4ed6706ff62dea642ab37b118a00d81bef2af::liquidate::emit_lowerst_cr_debtor_info<T0>(v0, arg1, arg9);
        } else {
            let (v4, v5) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_mint(arg0, arg3, arg8);
            let v6 = 0xbb2a79cc8c35256bb8017f5a6d4ed6706ff62dea642ab37b118a00d81bef2af::liquidate::liquidate_debtors<T0>(arg0, arg1, v3, arg9);
            let (v7, v8, v9) = 0x8487f1ef5dd63f10229957767a08ba519d10ebcb386bb6b5c9ac4b7647db8639::tank::withdraw_all<T0>(arg0, arg1, arg9, arg2, 0x8487f1ef5dd63f10229957767a08ba519d10ebcb386bb6b5c9ac4b7647db8639::tank::deposit<T0>(arg0, v4, arg10), arg10);
            let v10 = v7;
            0x2::balance::join<T0>(&mut v6, v8);
            0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v10, 0x631096118c05c328e40c7bd134b6a38b596034e22800f3614a21c35112c2eb2d::cetus::unsafe_swap_xsui_to_buck<T0>(arg4, arg5, arg6, arg7, v6, arg9));
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_burn(arg0, arg3, 0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v10, arg8 + 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg8, 500, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::fee_precision())), v5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v10, arg10), 0x2::tx_context::sender(arg10));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(v9, arg10), 0x2::tx_context::sender(arg10));
        };
    }

    // decompiled from Move bytecode v6
}

