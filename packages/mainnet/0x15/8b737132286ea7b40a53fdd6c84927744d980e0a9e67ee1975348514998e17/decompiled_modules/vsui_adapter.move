module 0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::vsui_adapter {
    struct VSUI_ADAPTER_AUTH has drop {
        dummy_field: bool,
    }

    fun stake_sui(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT> {
        0x2::coin::into_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::stake_non_entry(arg1, arg3, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg4), arg4))
    }

    fun unstake_vsui(arg0: 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::mint_ticket_non_entry(arg1, arg3, 0x2::coin::from_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, arg4), arg4);
        assert!(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::unstake_ticket::is_unlocked(&v0, arg4), 0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::error::vsui_unstake_locked());
        0x2::coin::into_balance<0x2::sui::SUI>(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::burn_ticket_non_entry(arg1, arg2, v0, arg4))
    }

    public fun vsui_handler(arg0: 0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::drift::RebalanceAdapterReceipt<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0x2::tx_context::TxContext) : 0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::drift::RebalanceAdapterReceipt<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI> {
        assert!(0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::drift::receipt_target_handler<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&arg0) == 0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::utils::generate_auth_token<VSUI_ADAPTER_AUTH>(), 0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::error::invalid_target_adapter());
        assert!(!0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::drift::is_processed<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&arg0), 0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::error::receipt_already_processed());
        let v0 = 0x2::balance::zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>();
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        let (_, v3, v4) = 0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::drift::receipt_prices<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&arg0);
        let (v5, v6) = 0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::drift::receipt_position_tick_index<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&arg0);
        let v7 = VSUI_ADAPTER_AUTH{dummy_field: false};
        let (v8, v9) = 0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::drift::extract_assets<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, VSUI_ADAPTER_AUTH>(&mut arg0, &v7);
        let v10 = v9;
        let v11 = v8;
        let (v12, v13) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity_math::get_amounts_for_liquidity(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(arg1), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v5), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v6), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::liquidity<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(arg1), false);
        if (v12 == 0) {
            if (0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v11) >= 1000000000) {
                0x2::balance::join<0x2::sui::SUI>(&mut v1, unstake_vsui(v11, arg2, arg3, arg4, arg5));
                0x2::balance::join<0x2::sui::SUI>(&mut v1, v10);
            } else {
                0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v0, v11);
                0x2::balance::join<0x2::sui::SUI>(&mut v1, v10);
            };
        } else if (v13 == 0) {
            if (0x2::balance::value<0x2::sui::SUI>(&v10) >= 1000000000) {
                0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v0, stake_sui(v10, arg2, arg3, arg4, arg5));
                0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v0, v11);
            } else {
                0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v0, v11);
                0x2::balance::join<0x2::sui::SUI>(&mut v1, v10);
            };
        } else if (0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v11) == 0) {
            0x2::balance::destroy_zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v11);
            let v14 = ((((((v12 as u128) / (v13 as u128)) as u64) as u128) * (0x2::balance::value<0x2::sui::SUI>(&v10) as u128) / (v4 as u128)) as u64);
            if (v14 >= 1000000000) {
                0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v0, stake_sui(0x2::balance::split<0x2::sui::SUI>(&mut v10, v14), arg2, arg3, arg4, arg5));
            };
            0x2::balance::join<0x2::sui::SUI>(&mut v1, v10);
        } else if (0x2::balance::value<0x2::sui::SUI>(&v10) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v10);
            let v15 = 0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v11) / ((((v3 as u128) * ((((v12 as u128) / (v13 as u128)) as u64) as u128)) as u64) + 1);
            if (v15 >= 1000000000) {
                0x2::balance::join<0x2::sui::SUI>(&mut v1, unstake_vsui(0x2::balance::split<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v11, v15), arg2, arg3, arg4, arg5));
            };
            0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v0, v11);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v10);
            0x2::balance::destroy_zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v11);
            abort 69420
        };
        0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::drift::fill_assets<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&mut arg0, v0, v1);
        let v16 = VSUI_ADAPTER_AUTH{dummy_field: false};
        0x158b737132286ea7b40a53fdd6c84927744d980e0a9e67ee1975348514998e17::drift::mark_processed<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, VSUI_ADAPTER_AUTH>(&mut arg0, &v16);
        arg0
    }

    // decompiled from Move bytecode v6
}

