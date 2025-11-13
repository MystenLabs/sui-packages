module 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::asset_admin {
    struct AssetOnboardedEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        interest_model: 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::interest::InterestModel,
        asset_config: 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::asset::AssetConfig,
        time: u64,
        operator: address,
    }

    struct AssetUpdated<T0> has copy, drop {
        what: u8,
        market: 0x1::type_name::TypeName,
        asset: 0x1::type_name::TypeName,
        new: T0,
    }

    public fun create_interest_model(arg0: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::interest::InterestModel {
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::interest::new(0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from_quotient(arg1, 1000000000000000000), 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from_quotient(arg2, 1000000000000000000), 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from_quotient(arg3, 10000), 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from_quotient(arg4, 1000000000000000000), 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from_quotient(arg5, 10000), 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from_quotient(arg6, 1000000000000000000))
    }

    public fun create_market_asset_config(arg0: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::asset::AssetConfig {
        assert!(arg1 > 0, 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::error::invalid_params_error());
        assert!(arg4 <= 10000, 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::error::invalid_params_error());
        assert!(arg3 <= 10000, 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::error::invalid_params_error());
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::asset::new_asset_config(arg1, 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from_quotient(arg3, 10000), arg2, 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from_quotient(arg4, 10000))
    }

    public fun onboard_new_asset<T0, T1>(arg0: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::AdminCap, arg1: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::ProtocolApp, arg2: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg3: 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::interest::InterestModel, arg4: 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::asset::AssetConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::has_circuit_break_triggered<T0>(arg2), 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::error::market_under_circuit_break());
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::validate_market<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::onboard_new_asset<T0, T1>(arg2, arg3, arg4, v0, arg6);
        let v1 = AssetOnboardedEvent{
            market         : 0x1::type_name::get<T0>(),
            interest_model : arg3,
            asset_config   : arg4,
            time           : v0,
            operator       : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<AssetOnboardedEvent>(v1);
    }

    public fun update_asset_paused_state<T0, T1>(arg0: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::AdminCap, arg1: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::ProtocolApp, arg2: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg3: u8, arg4: bool) {
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::validate_market<T0>(arg1, arg2);
        assert!(!0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::has_circuit_break_triggered<T0>(arg2), 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::error::market_under_circuit_break());
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::asset::change_operation_status<T0>(0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::market_asset_borrow_mut<T0, T1>(arg2), arg3, arg4);
        let v0 = AssetUpdated<bool>{
            what   : 2 + arg3,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg4,
        };
        0x2::event::emit<AssetUpdated<bool>>(v0);
    }

    public fun update_market_asset_config<T0, T1>(arg0: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::AdminCap, arg1: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::ProtocolApp, arg2: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg3: 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::asset::AssetConfig) {
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::validate_market<T0>(arg1, arg2);
        assert!(!0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::has_circuit_break_triggered<T0>(arg2), 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::error::market_under_circuit_break());
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::asset::update_asset_config<T0>(0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::market_asset_borrow_mut<T0, T1>(arg2), arg3);
        let v0 = AssetUpdated<0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::asset::AssetConfig>{
            what   : 0,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::asset::AssetConfig>>(v0);
    }

    public fun update_market_asset_interest_model<T0, T1>(arg0: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::AdminCap, arg1: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::ProtocolApp, arg2: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg3: 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::interest::InterestModel) {
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::validate_market<T0>(arg1, arg2);
        assert!(!0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::has_circuit_break_triggered<T0>(arg2), 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::error::market_under_circuit_break());
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::asset::update_interest_model<T0>(0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::market_asset_borrow_mut<T0, T1>(arg2), arg3);
        let v0 = AssetUpdated<0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::interest::InterestModel>{
            what   : 1,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::interest::InterestModel>>(v0);
    }

    // decompiled from Move bytecode v6
}

