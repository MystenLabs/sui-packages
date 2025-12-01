module 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset_admin {
    struct AssetOnboardedEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        interest_model: 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::interest::InterestModel,
        asset_config: 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::AssetConfig,
        time: u64,
        operator: address,
    }

    struct AssetUpdated<T0> has copy, drop {
        what: u8,
        market: 0x1::type_name::TypeName,
        asset: 0x1::type_name::TypeName,
        new: T0,
    }

    public fun create_interest_model(arg0: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::interest::InterestModel {
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::interest::new(0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::from_quotient(arg1, 1000000000000000000), 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::from_quotient(arg2, 1000000000000000000), 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::from_quotient(arg3, 10000), 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::from_quotient(arg4, 1000000000000000000), 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::from_quotient(arg5, 10000), 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::from_quotient(arg6, 1000000000000000000))
    }

    public fun create_market_asset_config(arg0: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::AssetConfig {
        assert!(arg1 > 0, 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::invalid_params_error());
        assert!(arg4 <= 10000, 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::invalid_params_error());
        assert!(arg3 <= 10000, 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::invalid_params_error());
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::new_asset_config(arg1, 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::from_quotient(arg3, 10000), arg2, 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::from_quotient(arg4, 10000))
    }

    public fun onboard_new_asset<T0, T1>(arg0: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::AdminCap, arg1: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::ProtocolApp, arg2: &mut 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::Market<T0>, arg3: 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::interest::InterestModel, arg4: 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::AssetConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::has_circuit_break_triggered<T0>(arg2), 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::market_under_circuit_break());
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::validate_market<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::onboard_new_asset<T0, T1>(arg2, arg3, arg4, v0, arg6);
        let v1 = AssetOnboardedEvent{
            market         : 0x1::type_name::get<T0>(),
            interest_model : arg3,
            asset_config   : arg4,
            time           : v0,
            operator       : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<AssetOnboardedEvent>(v1);
    }

    public fun update_asset_paused_state<T0, T1>(arg0: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::AdminCap, arg1: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::ProtocolApp, arg2: &mut 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::Market<T0>, arg3: u8, arg4: bool) {
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::validate_market<T0>(arg1, arg2);
        assert!(!0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::has_circuit_break_triggered<T0>(arg2), 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::market_under_circuit_break());
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::change_operation_status<T0>(0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::market_asset_borrow_mut<T0, T1>(arg2), arg3, arg4);
        let v0 = AssetUpdated<bool>{
            what   : 2 + arg3,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg4,
        };
        0x2::event::emit<AssetUpdated<bool>>(v0);
    }

    public fun update_market_asset_config<T0, T1>(arg0: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::AdminCap, arg1: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::ProtocolApp, arg2: &mut 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::Market<T0>, arg3: 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::AssetConfig) {
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::validate_market<T0>(arg1, arg2);
        assert!(!0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::has_circuit_break_triggered<T0>(arg2), 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::market_under_circuit_break());
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::update_asset_config<T0>(0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::market_asset_borrow_mut<T0, T1>(arg2), arg3);
        let v0 = AssetUpdated<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::AssetConfig>{
            what   : 0,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::AssetConfig>>(v0);
    }

    public fun update_market_asset_interest_model<T0, T1>(arg0: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::AdminCap, arg1: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::ProtocolApp, arg2: &mut 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::Market<T0>, arg3: 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::interest::InterestModel) {
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::validate_market<T0>(arg1, arg2);
        assert!(!0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::has_circuit_break_triggered<T0>(arg2), 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::market_under_circuit_break());
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset::update_interest_model<T0>(0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::market_asset_borrow_mut<T0, T1>(arg2), arg3);
        let v0 = AssetUpdated<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::interest::InterestModel>{
            what   : 1,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::interest::InterestModel>>(v0);
    }

    // decompiled from Move bytecode v6
}

