module 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::asset_ratio_handler {
    public fun vsui_handler(arg0: 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::drift::RebalanceAdapterReceipt<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0x2::tx_context::TxContext) : 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::drift::RebalanceAdapterReceipt<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI> {
        assert!(0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::drift::receipt_target_handler<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&arg0) == 1, 0);
        let v0 = 0x2::balance::zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>();
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        let (v2, v3, v4) = 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::drift::receipt_prices<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&arg0);
        let (v5, v6) = 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::drift::receipt_position_tick_index<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&arg0);
        let (v7, v8) = 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::drift::extract_assets<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&mut arg0);
        let v9 = v8;
        let v10 = v7;
        let (v11, v12) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity_math::get_amounts_for_liquidity(v2, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v5), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v6), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::liquidity<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(arg1), false);
        if (0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v10) == 0) {
            0x2::balance::destroy_zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v10);
            let v13 = (((v11 as u128) / (v12 as u128)) as u64) * 0x2::balance::value<0x2::sui::SUI>(&v9) / 0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::utils::get_b_to_a_price(v3, v4);
            if (v13 >= 1000000000) {
                0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v0, 0x2::coin::into_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::stake_non_entry(arg2, arg4, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v9, v13), arg5), arg5)));
            };
            0x2::balance::join<0x2::sui::SUI>(&mut v1, v9);
        } else if (0x2::balance::value<0x2::sui::SUI>(&v9) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
            let v14 = 0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v10) / (0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::utils::get_a_to_b_price(v3, v4) * (((v11 as u128) / (v12 as u128)) as u64) + 1);
            if (v14 >= 1000000000) {
                let v15 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::mint_ticket_non_entry(arg2, arg4, 0x2::coin::from_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0x2::balance::split<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v10, v14), arg5), arg5);
                assert!(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::unstake_ticket::is_unlocked(&v15, arg5), 0);
                0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x2::coin::into_balance<0x2::sui::SUI>(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::burn_ticket_non_entry(arg2, arg3, v15, arg5)));
            };
            0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v0, v10);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
            0x2::balance::destroy_zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v10);
            abort 10
        };
        0x26551bd0ce3ffd46c514539c992961404a88a45f1b117c13e1c4afb15defee6f::drift::fill_assets<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&mut arg0, v0, v1);
        arg0
    }

    // decompiled from Move bytecode v6
}

