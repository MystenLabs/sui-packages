module 0x87ad8aa78138eeb6cea995758ccabc8ba6840ff052e9cdcd6d3fe8c2f930dde7::flash_liquidate_by_cetus {
    public entry fun unsafe_flash_liquidate_all_xsui<T0, T1, T2>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintConfig, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x87ad8aa78138eeb6cea995758ccabc8ba6840ff052e9cdcd6d3fe8c2f930dde7::liquidate::get_liquidable_debtors<0x2::sui::SUI>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<0x2::sui::SUI>(arg0), arg1, arg11);
        let v1 = 0x87ad8aa78138eeb6cea995758ccabc8ba6840ff052e9cdcd6d3fe8c2f930dde7::liquidate::get_liquidable_debtors<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0), arg1, arg11);
        let v2 = 0x87ad8aa78138eeb6cea995758ccabc8ba6840ff052e9cdcd6d3fe8c2f930dde7::liquidate::get_liquidable_debtors<T1>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T1>(arg0), arg1, arg11);
        let v3 = 0x87ad8aa78138eeb6cea995758ccabc8ba6840ff052e9cdcd6d3fe8c2f930dde7::liquidate::get_liquidable_debtors<T2>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T2>(arg0), arg1, arg11);
        if (0x1::vector::is_empty<address>(&v0) && 0x1::vector::is_empty<address>(&v1) && 0x1::vector::is_empty<address>(&v2) && 0x1::vector::is_empty<address>(&v3)) {
        } else {
            let (v4, v5) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_mint(arg0, arg3, arg10);
            let v6 = v4;
            let v7 = 0x2::balance::zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>();
            if (!0x1::vector::is_empty<address>(&v0)) {
                let (v8, v9, v10) = 0x87ad8aa78138eeb6cea995758ccabc8ba6840ff052e9cdcd6d3fe8c2f930dde7::liquidate_with_buck::liquidate_debtors_with_buck<0x2::sui::SUI>(arg0, arg1, arg2, v0, 0x2::balance::withdraw_all<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v6), arg11, arg12);
                0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v6, 0x631096118c05c328e40c7bd134b6a38b596034e22800f3614a21c35112c2eb2d::cetus::unsafe_swap_sui_to_buck(arg4, arg8, arg9, v9, arg11));
                0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v6, v8);
                0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(&mut v7, v10);
            };
            if (!0x1::vector::is_empty<address>(&v1)) {
                let (v11, v12, v13) = 0x87ad8aa78138eeb6cea995758ccabc8ba6840ff052e9cdcd6d3fe8c2f930dde7::liquidate_with_buck::liquidate_debtors_with_buck<T0>(arg0, arg1, arg2, v1, 0x2::balance::withdraw_all<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v6), arg11, arg12);
                0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v6, 0x631096118c05c328e40c7bd134b6a38b596034e22800f3614a21c35112c2eb2d::cetus::unsafe_swap_xsui_to_buck<T0>(arg4, arg5, arg8, arg9, v12, arg11));
                0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v6, v11);
                0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(&mut v7, v13);
            };
            if (!0x1::vector::is_empty<address>(&v2)) {
                let (v14, v15, v16) = 0x87ad8aa78138eeb6cea995758ccabc8ba6840ff052e9cdcd6d3fe8c2f930dde7::liquidate_with_buck::liquidate_debtors_with_buck<T1>(arg0, arg1, arg2, v2, 0x2::balance::withdraw_all<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v6), arg11, arg12);
                0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v6, 0x631096118c05c328e40c7bd134b6a38b596034e22800f3614a21c35112c2eb2d::cetus::unsafe_swap_xsui_to_buck<T1>(arg4, arg6, arg8, arg9, v15, arg11));
                0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v6, v14);
                0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(&mut v7, v16);
            };
            if (!0x1::vector::is_empty<address>(&v3)) {
                let (v17, v18, v19) = 0x87ad8aa78138eeb6cea995758ccabc8ba6840ff052e9cdcd6d3fe8c2f930dde7::liquidate_with_buck::liquidate_debtors_with_buck<T2>(arg0, arg1, arg2, v3, 0x2::balance::withdraw_all<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v6), arg11, arg12);
                0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v6, 0x631096118c05c328e40c7bd134b6a38b596034e22800f3614a21c35112c2eb2d::cetus::unsafe_swap_xsui_to_buck<T2>(arg4, arg7, arg8, arg9, v18, arg11));
                0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v6, v17);
                0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(&mut v7, v19);
            };
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_burn(arg0, arg3, 0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v6, arg10 + 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg10, 500, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::fee_precision())), v5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v6, arg12), 0x2::tx_context::sender(arg12));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(v7, arg12), 0x2::tx_context::sender(arg12));
        };
    }

    public entry fun unsafe_flash_liquidate_sui(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintConfig, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<0x2::sui::SUI>(arg0);
        let v1 = 0x87ad8aa78138eeb6cea995758ccabc8ba6840ff052e9cdcd6d3fe8c2f930dde7::liquidate::get_liquidable_debtors<0x2::sui::SUI>(v0, arg1, arg8);
        if (0x1::vector::is_empty<address>(&v1)) {
            0x87ad8aa78138eeb6cea995758ccabc8ba6840ff052e9cdcd6d3fe8c2f930dde7::liquidate::emit_lowerst_cr_debtor_info<0x2::sui::SUI>(v0, arg1, arg8);
        } else {
            let (v2, v3) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_mint(arg0, arg3, arg7);
            let (v4, v5, v6) = 0x87ad8aa78138eeb6cea995758ccabc8ba6840ff052e9cdcd6d3fe8c2f930dde7::liquidate_with_buck::liquidate_debtors_with_buck<0x2::sui::SUI>(arg0, arg1, arg2, v1, v2, arg8, arg9);
            let v7 = v4;
            0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v7, 0x631096118c05c328e40c7bd134b6a38b596034e22800f3614a21c35112c2eb2d::cetus::unsafe_swap_sui_to_buck(arg4, arg5, arg6, v5, arg8));
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_burn(arg0, arg3, 0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v7, arg7 + 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg7, 500, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::fee_precision())), v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v7, arg9), 0x2::tx_context::sender(arg9));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(v6, arg9), 0x2::tx_context::sender(arg9));
        };
    }

    public entry fun unsafe_flash_liquidate_xsui<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::FlashMintConfig, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
        let v1 = 0x87ad8aa78138eeb6cea995758ccabc8ba6840ff052e9cdcd6d3fe8c2f930dde7::liquidate::get_liquidable_debtors<T0>(v0, arg1, arg9);
        if (0x1::vector::is_empty<address>(&v1)) {
            0x87ad8aa78138eeb6cea995758ccabc8ba6840ff052e9cdcd6d3fe8c2f930dde7::liquidate::emit_lowerst_cr_debtor_info<T0>(v0, arg1, arg9);
        } else {
            let (v2, v3) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_mint(arg0, arg3, arg8);
            let (v4, v5, v6) = 0x87ad8aa78138eeb6cea995758ccabc8ba6840ff052e9cdcd6d3fe8c2f930dde7::liquidate_with_buck::liquidate_debtors_with_buck<T0>(arg0, arg1, arg2, v1, v2, arg9, arg10);
            let v7 = v4;
            0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v7, 0x631096118c05c328e40c7bd134b6a38b596034e22800f3614a21c35112c2eb2d::cetus::unsafe_swap_xsui_to_buck<T0>(arg4, arg5, arg6, arg7, v5, arg9));
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_burn(arg0, arg3, 0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v7, arg8 + 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg8, 500, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::fee_precision())), v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v7, arg10), 0x2::tx_context::sender(arg10));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(v6, arg10), 0x2::tx_context::sender(arg10));
        };
    }

    // decompiled from Move bytecode v6
}

