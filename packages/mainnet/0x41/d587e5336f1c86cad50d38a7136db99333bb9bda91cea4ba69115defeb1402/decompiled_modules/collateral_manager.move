module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_manager {
    struct CollateralManagerRole {
        dummy_field: bool,
    }

    public fun set_custodian_address<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<CollateralManagerRole>, arg2: address) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_collateral_custodian_address_updated<T0>(arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::set_custodian_address<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::collateral_mut<T0>(arg0), arg2);
    }

    public fun add_collateral<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<CollateralManagerRole>, arg2: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::CollateralConfig<T0>) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_collateral_added<T0>();
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::set_enabled<T0>(&mut arg2, false);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::add_collateral<T0>(arg0, arg2);
    }

    public fun remove_collateral<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<CollateralManagerRole>) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_collateral_removed<T0>();
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::remove_collateral<T0>(arg0);
    }

    public fun set_collateral_default_fees<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<CollateralManagerRole>, arg2: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_collateral_default_fees_updated<T0>(arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::set_default_fees<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::collateral_mut<T0>(arg0), arg2);
    }

    public fun set_collateral_limits<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<CollateralManagerRole>, arg2: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_collateral_limits_updated<T0>(arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::set_epoch_limits(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::limiter_mut<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::collateral_mut<T0>(arg0)), *0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::epoch(&arg2));
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limiter::set_period_limits(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::limiter_mut<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::collateral_mut<T0>(arg0)), *0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::period(&arg2));
    }

    public fun set_collateral_max_age_ms<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<CollateralManagerRole>, arg2: u64) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_collateral_oracle_max_age_updated<T0>(arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::set_max_age_ms(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::oracle_limits_mut<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::collateral_mut<T0>(arg0)), arg2);
    }

    public fun set_collateral_max_price<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<CollateralManagerRole>, arg2: u64) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_collateral_oracle_max_price_updated<T0>(arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::set_max_price(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::oracle_limits_mut<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::collateral_mut<T0>(arg0)), arg2);
    }

    public fun set_collateral_min_price<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<CollateralManagerRole>, arg2: u64) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_collateral_oracle_min_price_updated<T0>(arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::set_min_price(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::oracle_limits_mut<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::collateral_mut<T0>(arg0)), arg2);
    }

    public fun set_collateral_oracle<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<CollateralManagerRole>, arg2: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::AggregatedOracle) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_collateral_oracle_id_updated<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::id(arg2));
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::set_oracle<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::collateral_mut<T0>(arg0), arg2);
    }

    public fun transfer_to_custody<T0>(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<CollateralManagerRole>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 13835339800841814017);
        let v0 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::collateral_mut<T0>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::redeem_balance_mut<T0>(v0), arg2), arg3), 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::custodian_address<T0>(v0));
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_custody_transfer<T0>(arg2, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::custodian_address<T0>(v0));
    }

    // decompiled from Move bytecode v6
}

