module 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset_admin {
    struct AssetOnboardedEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        interest_model: 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::interest::InterestModel,
        borrow_config: 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::BorrowConfig,
        collateral_setting: 0x1::option::Option<0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::Collateral>,
        time: u64,
        operator: address,
    }

    struct AssetUpdated<T0> has copy, drop {
        what: u8,
        market: 0x1::type_name::TypeName,
        asset: 0x1::type_name::TypeName,
        new: T0,
    }

    public fun create_borrow_config(arg0: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::BorrowConfig {
        assert!(arg1 > 0, 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::error::invalid_params_error());
        assert!(arg2 >= arg1, 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::error::invalid_params_error());
        assert!(arg4 <= 10000, 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::error::invalid_params_error());
        assert!(arg5 <= 10000, 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::error::invalid_params_error());
        assert!(arg6 >= 10000, 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::error::invalid_params_error());
        0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::new_borrow_config(arg1, arg2, 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::from_quotient(arg4, 10000), 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::from_quotient(arg5, 10000), arg3, 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::from_quotient(arg6, 10000))
    }

    public fun create_collateral_config(arg0: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::Collateral {
        assert!(arg1 <= 10000, 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::error::invalid_params_error());
        assert!(arg2 <= 10000, 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::error::invalid_params_error());
        assert!(arg3 <= 10000, 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::error::invalid_params_error());
        assert!(arg4 <= 10000, 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::error::invalid_params_error());
        0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::new_collateral(0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::from_quotient(arg1, 10000), 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::from_quotient(arg2, 10000), 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::from_quotient(arg3, 10000), 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::from_quotient(arg4, 10000))
    }

    public fun create_interest_model(arg0: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::interest::InterestModel {
        0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::interest::new(0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::from_quotient(arg1, 1000000000000000000), 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::from_quotient(arg2, 1000000000000000000), 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::from_quotient(arg3, 10000), 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::from_quotient(arg4, 1000000000000000000), 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::from_quotient(arg5, 10000), 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::from_quotient(arg6, 1000000000000000000))
    }

    public fun enable_asset_collateral<T0, T1>(arg0: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::AdminCap, arg1: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::ProtocolApp, arg2: &mut 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::Market<T0>, arg3: 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::Collateral) {
        0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::validate_market<T0>(arg1, arg2);
        0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::enable_asset_collateral<T0, T1>(arg2, arg3);
        let v0 = AssetUpdated<0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::Collateral>{
            what   : 1,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::Collateral>>(v0);
    }

    public fun onboard_new_asset<T0, T1>(arg0: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::AdminCap, arg1: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::ProtocolApp, arg2: &mut 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::Market<T0>, arg3: 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::interest::InterestModel, arg4: 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::BorrowConfig, arg5: 0x1::option::Option<0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::Collateral>, arg6: 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::limiter::NewLimiter, arg7: 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::limiter::NewLimiter, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::validate_market<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg8) / 1000;
        0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::onboard_new_asset<T0, T1>(arg2, arg3, arg4, arg6, arg7, v0, arg9);
        if (0x1::option::is_some<0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::Collateral>(&arg5)) {
            0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::enable_asset_collateral<T0, T1>(arg2, *0x1::option::borrow<0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::Collateral>(&arg5));
        };
        let v1 = AssetOnboardedEvent{
            market             : 0x1::type_name::get<T0>(),
            interest_model     : arg3,
            borrow_config      : arg4,
            collateral_setting : arg5,
            time               : v0,
            operator           : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<AssetOnboardedEvent>(v1);
    }

    public fun update_asset_borrow<T0, T1>(arg0: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::AdminCap, arg1: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::ProtocolApp, arg2: &mut 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::Market<T0>, arg3: 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::BorrowConfig) {
        0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::validate_market<T0>(arg1, arg2);
        0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::update_asset_borrow<T0, T1>(arg2, arg3);
        let v0 = AssetUpdated<0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::BorrowConfig>{
            what   : 2,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::BorrowConfig>>(v0);
    }

    public fun update_asset_collateral<T0, T1>(arg0: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::AdminCap, arg1: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::ProtocolApp, arg2: &mut 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::Market<T0>, arg3: 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::Collateral) {
        0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::validate_market<T0>(arg1, arg2);
        0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::update_asset_collateral<T0, T1>(arg2, arg3);
        let v0 = AssetUpdated<0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::Collateral>{
            what   : 1,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::asset::Collateral>>(v0);
    }

    public fun update_asset_paused_state<T0, T1>(arg0: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::AdminCap, arg1: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::ProtocolApp, arg2: &mut 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::Market<T0>, arg3: u8, arg4: bool) {
        0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::validate_market<T0>(arg1, arg2);
        0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::change_operation_status<T0, T1>(arg2, arg3, arg4);
        let v0 = AssetUpdated<bool>{
            what   : 4 + arg3,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg4,
        };
        0x2::event::emit<AssetUpdated<bool>>(v0);
    }

    public fun update_interest_model<T0, T1>(arg0: &0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::app::AdminCap, arg1: &mut 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::Market<T0>, arg2: 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::interest::InterestModel) {
        0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::market::update_interest_model<T0, T1>(arg1, arg2);
        let v0 = AssetUpdated<0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::interest::InterestModel>{
            what   : 3,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg2,
        };
        0x2::event::emit<AssetUpdated<0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::interest::InterestModel>>(v0);
    }

    // decompiled from Move bytecode v6
}

