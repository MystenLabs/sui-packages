module 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset_admin {
    struct AssetOnboardedEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        interest_model: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::interest::InterestModel,
        borrow_config: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::BorrowConfig,
        collateral_setting: 0x1::option::Option<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::Collateral>,
        time: u64,
        operator: address,
    }

    struct AssetUpdated<T0> has copy, drop {
        what: u8,
        market: 0x1::type_name::TypeName,
        asset: 0x1::type_name::TypeName,
        new: T0,
    }

    public fun create_borrow_config(arg0: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::BorrowConfig {
        assert!(arg1 > 0, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error::invalid_params_error());
        assert!(arg2 >= arg1, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error::invalid_params_error());
        assert!(arg4 <= 10000, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error::invalid_params_error());
        assert!(arg5 <= 10000, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error::invalid_params_error());
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::new_borrow_config(arg1, arg2, 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::from_quotient(arg4, 10000), 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::from_quotient(arg5, 10000), arg3)
    }

    public fun create_collateral_config(arg0: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::AdminCap, arg1: u64, arg2: u64, arg3: u64) : 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::Collateral {
        assert!(arg1 <= 10000, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error::invalid_params_error());
        assert!(arg2 <= 10000, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error::invalid_params_error());
        assert!(arg3 <= 10000, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error::invalid_params_error());
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::new_collateral(0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::from_quotient(arg1, 10000), 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::from_quotient(arg2, 10000), 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::from_quotient(arg3, 10000))
    }

    public fun create_interest_model(arg0: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::interest::InterestModel {
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::interest::new(0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::from_quotient(arg1, 1000000000000000000), 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::from_quotient(arg2, 1000000000000000000), 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::from_quotient(arg3, 10000), 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::from_quotient(arg4, 1000000000000000000), 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::from_quotient(arg5, 10000), 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::from_quotient(arg6, 1000000000000000000))
    }

    public fun enable_asset_collateral<T0, T1>(arg0: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::AdminCap, arg1: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::ProtocolApp, arg2: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg3: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::Collateral) {
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::validate_market<T0>(arg1, arg2);
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::enable_asset_collateral<T0, T1>(arg2, arg3);
        let v0 = AssetUpdated<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::Collateral>{
            what   : 1,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::Collateral>>(v0);
    }

    public fun onboard_asset<T0, T1>(arg0: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::AdminCap, arg1: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::ProtocolApp, arg2: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg3: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::interest::InterestModel, arg4: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::BorrowConfig, arg5: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::limiter::NewLimiter, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::validate_market<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::onboard_new_asset<T0, T1>(arg2, arg3, arg4, arg5, v0, arg7);
        let v1 = AssetOnboardedEvent{
            market             : 0x1::type_name::get<T0>(),
            interest_model     : arg3,
            borrow_config      : arg4,
            collateral_setting : 0x1::option::none<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::Collateral>(),
            time               : v0,
            operator           : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<AssetOnboardedEvent>(v1);
    }

    public fun onboard_collateral_asset<T0, T1>(arg0: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::AdminCap, arg1: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::ProtocolApp, arg2: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg3: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::interest::InterestModel, arg4: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::BorrowConfig, arg5: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::Collateral, arg6: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::limiter::NewLimiter, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::validate_market<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg7) / 1000;
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::onboard_new_asset<T0, T1>(arg2, arg3, arg4, arg6, v0, arg8);
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::enable_asset_collateral<T0, T1>(arg2, arg5);
        let v1 = AssetOnboardedEvent{
            market             : 0x1::type_name::get<T0>(),
            interest_model     : arg3,
            borrow_config      : arg4,
            collateral_setting : 0x1::option::some<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::Collateral>(arg5),
            time               : v0,
            operator           : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<AssetOnboardedEvent>(v1);
    }

    public fun update_asset_borrow<T0, T1>(arg0: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::AdminCap, arg1: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::ProtocolApp, arg2: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg3: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::BorrowConfig) {
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::validate_market<T0>(arg1, arg2);
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::update_asset_borrow<T0, T1>(arg2, arg3);
        let v0 = AssetUpdated<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::BorrowConfig>{
            what   : 2,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::BorrowConfig>>(v0);
    }

    public fun update_asset_collateral<T0, T1>(arg0: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::AdminCap, arg1: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::ProtocolApp, arg2: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg3: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::Collateral) {
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::validate_market<T0>(arg1, arg2);
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::update_asset_collateral<T0, T1>(arg2, arg3);
        let v0 = AssetUpdated<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::Collateral>{
            what   : 1,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::asset::Collateral>>(v0);
    }

    public fun update_asset_paused_state<T0, T1>(arg0: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::AdminCap, arg1: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::ProtocolApp, arg2: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg3: u8, arg4: bool) {
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::validate_market<T0>(arg1, arg2);
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::change_operation_status<T0, T1>(arg2, arg3, arg4);
        let v0 = AssetUpdated<bool>{
            what   : 4 + arg3,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg4,
        };
        0x2::event::emit<AssetUpdated<bool>>(v0);
    }

    public fun update_interest_model<T0, T1>(arg0: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::app::AdminCap, arg1: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg2: 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::interest::InterestModel) {
        0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::update_interest_model<T0, T1>(arg1, arg2);
        let v0 = AssetUpdated<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::interest::InterestModel>{
            what   : 3,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg2,
        };
        0x2::event::emit<AssetUpdated<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::interest::InterestModel>>(v0);
    }

    // decompiled from Move bytecode v6
}

