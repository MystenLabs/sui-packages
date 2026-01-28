module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor {
    public fun mint<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::BenefactorRole>, arg2: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::order::Order<T0>, arg3: &0x2::clock::Clock, arg4: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::OracleProof, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE> {
        validate_states<T0>(arg0, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::addr<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::BenefactorRole>(arg1), 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::order::nonce<T0>(&arg2));
        let v0 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::order::amount_in<T0>(&arg2);
        let v1 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::collateral<T0>(arg0);
        let v2 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::latest_price(arg4, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::oracle_id<T0>(v1), 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::oracle_limits<T0>(v1), true, arg3);
        let v3 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::default_fee<T0>(v1);
        let v4 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config::collateral_fees<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::benefactor(arg0, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::addr<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::BenefactorRole>(arg1)));
        let v5 = if (0x1::option::is_some<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee>(&v4)) {
            0x1::option::destroy_some<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee>(v4)
        } else {
            0x1::option::destroy_none<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee>(v4);
            v3
        };
        let v6 = v5;
        let v7 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::calculate_mint_fee(&v6, &v3);
        let v8 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::peg_price(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config(arg0));
        let v9 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::decimals<T0>(v1);
        let v10 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_helpers::collateral_to_suiusde_amount(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_helpers::fee_adjusted_amount(v0, v7), v9, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::default_decimals_multiplier(), v8);
        let v11 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_helpers::collateral_to_suiusde_amount(v0, v9, v2, v8);
        let v12 = 0x1::u64::min(v10, v11);
        update_and_verify_limiters<T0>(arg0, arg1, arg3, v12, true);
        let v13 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::collateral<T0>(arg0);
        assert!(v12 >= 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::order::min_amount_out<T0>(&arg2), 13835621374602903555);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_order_executed<T0>(true, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::addr<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::BenefactorRole>(arg1), v0, v12, v7, v10 < v11, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::order::nonce<T0>(&arg2), 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::order::expiry_ms<T0>(&arg2), 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::order::min_amount_out<T0>(&arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::order::finalize<T0>(arg2, arg3), 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::custodian_address<T0>(v13));
        0x2::coin::mint<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::treasury_cap_mut(arg0), v12, arg5)
    }

    public fun redeem<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::BenefactorRole>, arg2: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::order::Order<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>, arg3: &0x2::clock::Clock, arg4: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::OracleProof, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        validate_states<T0>(arg0, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::addr<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::BenefactorRole>(arg1), 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::order::nonce<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>(&arg2));
        let v0 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::order::amount_in<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>(&arg2);
        let v1 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::collateral<T0>(arg0);
        let v2 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_proof::latest_price(arg4, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::oracle_id<T0>(v1), 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::oracle_limits<T0>(v1), false, arg3);
        let v3 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::default_fee<T0>(v1);
        let v4 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config::collateral_fees<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::benefactor(arg0, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::addr<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::BenefactorRole>(arg1)));
        let v5 = if (0x1::option::is_some<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee>(&v4)) {
            0x1::option::destroy_some<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee>(v4)
        } else {
            0x1::option::destroy_none<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee>(v4);
            v3
        };
        let v6 = v5;
        let v7 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::calculate_redeem_fee(&v6, &v3);
        let v8 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::peg_price(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config(arg0));
        let v9 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::decimals<T0>(v1);
        let v10 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_helpers::suiusde_to_collateral_amount(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_helpers::fee_adjusted_amount(v0, v7), v9, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::default_decimals_multiplier(), v8);
        let v11 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_helpers::suiusde_to_collateral_amount(v0, v9, v2, v8);
        let v12 = 0x1::u64::min(v10, v11);
        update_and_verify_limiters<T0>(arg0, arg1, arg3, v0, false);
        let v13 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::redeem_balance_mut<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::collateral_mut<T0>(arg0));
        assert!(0x2::balance::value<T0>(v13) >= v12, 13835340264698281985);
        let v14 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v13, v12), arg5);
        assert!(0x2::coin::value<T0>(&v14) >= 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::order::min_amount_out<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>(&arg2), 13835621756854992899);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_order_executed<T0>(false, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::addr<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::BenefactorRole>(arg1), v0, v12, v7, v10 < v11, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::order::nonce<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>(&arg2), 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::order::expiry_ms<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>(&arg2), 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::order::min_amount_out<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>(&arg2));
        0x2::coin::burn<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::treasury_cap_mut(arg0), 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::order::finalize<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>(arg2, arg3));
        v14
    }

    fun update_and_verify_limiters<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::BenefactorRole>, arg2: &0x2::clock::Clock, arg3: u64, arg4: bool) {
        assert!(arg3 >= 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants::min_amount_usde(), 13835903407925493765);
        let v0 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config(arg0);
        let v1 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::epoch_duration_ms(v0);
        let v2 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::period_duration_ms(v0);
        if (arg4) {
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::add_mint(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::limiter_mut(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config_mut(arg0)), arg3, arg2, v1, v2, 0x1::option::none<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits>());
        } else {
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::add_redeem(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::limiter_mut(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config_mut(arg0)), arg3, arg2, v1, v2, 0x1::option::none<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits>());
        };
        if (arg4) {
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::add_mint(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::limiter_mut<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::collateral_mut<T0>(arg0)), arg3, arg2, v1, v2, 0x1::option::none<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits>());
        } else {
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::add_redeem(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::limiter_mut<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::collateral_mut<T0>(arg0)), arg3, arg2, v1, v2, 0x1::option::none<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits>());
        };
        if (arg4) {
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::add_mint(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config::limiter_mut(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::benefactor_mut(arg0, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::addr<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::BenefactorRole>(arg1))), arg3, arg2, v1, v2, 0x1::option::some<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits>(*0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::default_benefactor_limits(v0)));
        } else {
            0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::add_redeem(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config::limiter_mut(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::benefactor_mut(arg0, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::addr<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::BenefactorRole>(arg1))), arg3, arg2, v1, v2, 0x1::option::some<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits>(*0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::default_benefactor_limits(v0)));
        };
    }

    fun validate_states<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: address, arg2: 0x1::string::String) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_mint_redeem_enabled(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::config(arg0));
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::assert_is_enabled<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::collateral<T0>(arg0));
        let v0 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::benefactor_mut(arg0, arg1);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config::assert_is_enabled(v0);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config::add_nonce(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

