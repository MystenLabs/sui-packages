module 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset_admin {
    struct AssetOnboardedEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        interest_model: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::interest::InterestModel,
        asset_config: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::AssetConfig,
        time: u64,
        operator: address,
    }

    struct AssetUpdated<T0> has copy, drop {
        what: u8,
        market: 0x1::type_name::TypeName,
        asset: 0x1::type_name::TypeName,
        new: T0,
    }

    public fun create_interest_model(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::interest::InterestModel {
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::interest::new(0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg1, 1000000000000000000), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg2, 1000000000000000000), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg3, 10000), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg4, 1000000000000000000), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg5, 10000), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg6, 1000000000000000000))
    }

    public fun create_market_asset_config(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::AssetConfig {
        assert!(arg1 > 0, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::invalid_params_error());
        assert!(arg4 <= 10000, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::invalid_params_error());
        assert!(arg3 <= 10000, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::invalid_params_error());
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::new_asset_config(arg1, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg3, 10000), arg2, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg4, 10000))
    }

    public fun onboard_new_asset<T0, T1>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::AdminCap, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::ProtocolApp, arg2: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg3: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::interest::InterestModel, arg4: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::AssetConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::has_circuit_break_triggered<T0>(arg2), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::market_under_circuit_break());
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::validate_market<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::onboard_new_asset<T0, T1>(arg2, arg3, arg4, v0, arg6);
        let v1 = AssetOnboardedEvent{
            market         : 0x1::type_name::get<T0>(),
            interest_model : arg3,
            asset_config   : arg4,
            time           : v0,
            operator       : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<AssetOnboardedEvent>(v1);
    }

    public fun update_asset_paused_state<T0, T1>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::AdminCap, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::ProtocolApp, arg2: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg3: u8, arg4: bool) {
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::validate_market<T0>(arg1, arg2);
        assert!(!0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::has_circuit_break_triggered<T0>(arg2), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::market_under_circuit_break());
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::change_operation_status<T0>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::market_asset_borrow_mut<T0, T1>(arg2), arg3, arg4);
        let v0 = AssetUpdated<bool>{
            what   : 2 + arg3,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg4,
        };
        0x2::event::emit<AssetUpdated<bool>>(v0);
    }

    public fun update_market_asset_config<T0, T1>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::AdminCap, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::ProtocolApp, arg2: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg3: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::AssetConfig) {
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::validate_market<T0>(arg1, arg2);
        assert!(!0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::has_circuit_break_triggered<T0>(arg2), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::market_under_circuit_break());
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::update_asset_config<T0>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::market_asset_borrow_mut<T0, T1>(arg2), arg3);
        let v0 = AssetUpdated<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::AssetConfig>{
            what   : 0,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::AssetConfig>>(v0);
    }

    public fun update_market_asset_interest_model<T0, T1>(arg0: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::AdminCap, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::ProtocolApp, arg2: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg3: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::interest::InterestModel) {
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::validate_market<T0>(arg1, arg2);
        assert!(!0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::has_circuit_break_triggered<T0>(arg2), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::market_under_circuit_break());
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset::update_interest_model<T0>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::market_asset_borrow_mut<T0, T1>(arg2), arg3);
        let v0 = AssetUpdated<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::interest::InterestModel>{
            what   : 1,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::interest::InterestModel>>(v0);
    }

    // decompiled from Move bytecode v6
}

