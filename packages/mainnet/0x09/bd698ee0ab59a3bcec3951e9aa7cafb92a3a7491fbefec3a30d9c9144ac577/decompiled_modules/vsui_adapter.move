module 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::vsui_adapter {
    struct VSUI_ADAPTER_AUTH has drop {
        dummy_field: bool,
    }

    fun stake_sui(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT> {
        0x2::coin::into_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::stake_non_entry(arg1, arg3, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg4), arg4))
    }

    fun unstake_vsui(arg0: 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::mint_ticket_non_entry(arg1, arg3, 0x2::coin::from_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, arg4), arg4);
        assert!(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::unstake_ticket::is_unlocked(&v0, arg4), 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::error::vsui_unstake_locked());
        0x2::coin::into_balance<0x2::sui::SUI>(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::burn_ticket_non_entry(arg1, arg2, v0, arg4))
    }

    public fun vsui_handler(arg0: 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::drift::RebalanceAdapterReceipt<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0x2::tx_context::TxContext) : 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::drift::RebalanceAdapterReceipt<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI> {
        let v0 = VSUI_ADAPTER_AUTH{dummy_field: false};
        assert!(0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::drift::receipt_target_handler<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&arg0) == 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::utils::generate_auth_token<VSUI_ADAPTER_AUTH>(&v0), 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::error::invalid_target_adapter());
        assert!(!0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::drift::is_processed<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&arg0), 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::error::receipt_already_processed());
        let v1 = 0x2::balance::zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>();
        let v2 = 0x2::balance::zero<0x2::sui::SUI>();
        let (_, v4, v5) = 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::drift::receipt_prices<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&arg0);
        let (v6, v7) = 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::drift::receipt_position_tick_index<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&arg0);
        let v8 = VSUI_ADAPTER_AUTH{dummy_field: false};
        let (v9, v10) = 0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::drift::extract_assets<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, VSUI_ADAPTER_AUTH>(&mut arg0, &v8);
        let v11 = v10;
        let v12 = v9;
        let (v13, v14) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity_math::get_amounts_for_liquidity(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(arg1), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v6), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v7), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::liquidity<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(arg1), false);
        if (v13 == 0) {
            if (0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v12) >= 1000000000) {
                0x2::balance::join<0x2::sui::SUI>(&mut v2, unstake_vsui(v12, arg2, arg3, arg4, arg5));
                0x2::balance::join<0x2::sui::SUI>(&mut v2, v11);
            } else {
                0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v1, v12);
                0x2::balance::join<0x2::sui::SUI>(&mut v2, v11);
            };
        } else if (v14 == 0) {
            if (0x2::balance::value<0x2::sui::SUI>(&v11) >= 1000000000) {
                0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v1, stake_sui(v11, arg2, arg3, arg4, arg5));
                0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v1, v12);
            } else {
                0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v1, v12);
                0x2::balance::join<0x2::sui::SUI>(&mut v2, v11);
            };
        } else if (0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v12) == 0) {
            0x2::balance::destroy_zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v12);
            let v15 = ((((((v13 as u128) / (v14 as u128)) as u64) as u128) * (0x2::balance::value<0x2::sui::SUI>(&v11) as u128) / (v5 as u128)) as u64);
            if (v15 >= 1000000000) {
                0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v1, stake_sui(0x2::balance::split<0x2::sui::SUI>(&mut v11, v15), arg2, arg3, arg4, arg5));
            };
            0x2::balance::join<0x2::sui::SUI>(&mut v2, v11);
        } else if (0x2::balance::value<0x2::sui::SUI>(&v11) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v11);
            let v16 = 0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v12) / ((((v4 as u128) * ((((v13 as u128) / (v14 as u128)) as u64) as u128)) as u64) + 1);
            if (v16 >= 1000000000) {
                0x2::balance::join<0x2::sui::SUI>(&mut v2, unstake_vsui(0x2::balance::split<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v12, v16), arg2, arg3, arg4, arg5));
            };
            0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v1, v12);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v11);
            0x2::balance::destroy_zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v12);
            abort 69420
        };
        0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::drift::fill_assets<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&mut arg0, v1, v2);
        let v17 = VSUI_ADAPTER_AUTH{dummy_field: false};
        0x9bd698ee0ab59a3bcec3951e9aa7cafb92a3a7491fbefec3a30d9c9144ac577::drift::mark_processed<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI, VSUI_ADAPTER_AUTH>(&mut arg0, &v17);
        arg0
    }

    // decompiled from Move bytecode v6
}

