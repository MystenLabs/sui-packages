module 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset_admin {
    struct AssetOnboardedEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        interest_model: 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::interest::InterestModel,
        borrow_config: 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::BorrowConfig,
        collateral_setting: 0x1::option::Option<0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::Collateral>,
        time: u64,
        operator: address,
    }

    struct AssetUpdated<T0> has copy, drop {
        what: u8,
        market: 0x1::type_name::TypeName,
        asset: 0x1::type_name::TypeName,
        new: T0,
    }

    public fun create_borrow_config(arg0: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::BorrowConfig {
        assert!(arg1 > 0, 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::error::invalid_params_error());
        assert!(arg2 >= arg1, 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::error::invalid_params_error());
        assert!(arg4 <= 10000, 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::error::invalid_params_error());
        assert!(arg5 <= 10000, 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::error::invalid_params_error());
        assert!(arg6 >= 10000, 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::error::invalid_params_error());
        0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::new_borrow_config(arg1, arg2, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg4, 10000), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg5, 10000), arg3, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg6, 10000))
    }

    public fun create_collateral_config(arg0: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::Collateral {
        assert!(arg1 <= 10000, 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::error::invalid_params_error());
        assert!(arg2 <= 10000, 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::error::invalid_params_error());
        assert!(arg3 <= 10000, 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::error::invalid_params_error());
        assert!(arg4 <= 10000, 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::error::invalid_params_error());
        0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::new_collateral(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg1, 10000), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg2, 10000), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg3, 10000), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg4, 10000))
    }

    public fun create_interest_model(arg0: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::interest::InterestModel {
        0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::interest::new(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg1, 1000000000000000000), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg2, 1000000000000000000), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg3, 10000), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg4, 1000000000000000000), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg5, 10000), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(arg6, 1000000000000000000))
    }

    public fun enable_asset_collateral<T0, T1>(arg0: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::AdminCap, arg1: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::ProtocolApp, arg2: &mut 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::Market<T0>, arg3: 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::Collateral) {
        0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::validate_market<T0>(arg1, arg2);
        0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::enable_asset_collateral<T0, T1>(arg2, arg3);
        let v0 = AssetUpdated<0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::Collateral>{
            what   : 1,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::Collateral>>(v0);
    }

    public fun onboard_new_asset<T0, T1>(arg0: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::AdminCap, arg1: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::ProtocolApp, arg2: &mut 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::Market<T0>, arg3: 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::interest::InterestModel, arg4: 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::BorrowConfig, arg5: 0x1::option::Option<0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::Collateral>, arg6: 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::limiter::NewLimiter, arg7: 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::limiter::NewLimiter, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::validate_market<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg8) / 1000;
        0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::onboard_new_asset<T0, T1>(arg2, arg3, arg4, arg6, arg7, v0, arg9);
        if (0x1::option::is_some<0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::Collateral>(&arg5)) {
            0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::enable_asset_collateral<T0, T1>(arg2, *0x1::option::borrow<0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::Collateral>(&arg5));
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

    public fun update_asset_borrow<T0, T1>(arg0: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::AdminCap, arg1: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::ProtocolApp, arg2: &mut 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::Market<T0>, arg3: 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::BorrowConfig) {
        0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::validate_market<T0>(arg1, arg2);
        0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::update_asset_borrow<T0, T1>(arg2, arg3);
        let v0 = AssetUpdated<0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::BorrowConfig>{
            what   : 2,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::BorrowConfig>>(v0);
    }

    public fun update_asset_collateral<T0, T1>(arg0: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::AdminCap, arg1: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::ProtocolApp, arg2: &mut 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::Market<T0>, arg3: 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::Collateral) {
        0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::validate_market<T0>(arg1, arg2);
        0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::update_asset_collateral<T0, T1>(arg2, arg3);
        let v0 = AssetUpdated<0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::Collateral>{
            what   : 1,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::asset::Collateral>>(v0);
    }

    public fun update_asset_paused_state<T0, T1>(arg0: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::AdminCap, arg1: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::ProtocolApp, arg2: &mut 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::Market<T0>, arg3: u8, arg4: bool) {
        0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::validate_market<T0>(arg1, arg2);
        0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::change_operation_status<T0, T1>(arg2, arg3, arg4);
        let v0 = AssetUpdated<bool>{
            what   : 4 + arg3,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg4,
        };
        0x2::event::emit<AssetUpdated<bool>>(v0);
    }

    public fun update_interest_model<T0, T1>(arg0: &0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::app::AdminCap, arg1: &mut 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::Market<T0>, arg2: 0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::interest::InterestModel) {
        0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::market::update_interest_model<T0, T1>(arg1, arg2);
        let v0 = AssetUpdated<0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::interest::InterestModel>{
            what   : 3,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg2,
        };
        0x2::event::emit<AssetUpdated<0x26a7650bdcd108250f6ea265be27c8372dfe8fd33bef7131bc685086b6b851cb::interest::InterestModel>>(v0);
    }

    // decompiled from Move bytecode v6
}

