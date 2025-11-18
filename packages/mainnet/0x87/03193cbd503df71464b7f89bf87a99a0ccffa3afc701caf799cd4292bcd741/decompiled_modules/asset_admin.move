module 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset_admin {
    struct AssetOnboardedEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        interest_model: 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::interest::InterestModel,
        asset_config: 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::AssetConfig,
        time: u64,
        operator: address,
    }

    struct AssetUpdated<T0> has copy, drop {
        what: u8,
        market: 0x1::type_name::TypeName,
        asset: 0x1::type_name::TypeName,
        new: T0,
    }

    public fun create_interest_model(arg0: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::interest::InterestModel {
        0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::interest::new(0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg1, 1000000000000000000), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg2, 1000000000000000000), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg3, 10000), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg4, 1000000000000000000), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg5, 10000), 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg6, 1000000000000000000))
    }

    public fun create_market_asset_config(arg0: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::AssetConfig {
        assert!(arg1 > 0, 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::error::invalid_params_error());
        assert!(arg4 <= 10000, 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::error::invalid_params_error());
        assert!(arg3 <= 10000, 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::error::invalid_params_error());
        0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::new_asset_config(arg1, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg3, 10000), arg2, 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(arg4, 10000))
    }

    public fun onboard_new_asset<T0, T1>(arg0: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::AdminCap, arg1: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::ProtocolApp, arg2: &mut 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::Market<T0>, arg3: 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::interest::InterestModel, arg4: 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::AssetConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::has_circuit_break_triggered<T0>(arg2), 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::error::market_under_circuit_break());
        0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::validate_market<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::onboard_new_asset<T0, T1>(arg2, arg3, arg4, v0, arg6);
        let v1 = AssetOnboardedEvent{
            market         : 0x1::type_name::get<T0>(),
            interest_model : arg3,
            asset_config   : arg4,
            time           : v0,
            operator       : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<AssetOnboardedEvent>(v1);
    }

    public fun update_asset_paused_state<T0, T1>(arg0: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::AdminCap, arg1: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::ProtocolApp, arg2: &mut 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::Market<T0>, arg3: u8, arg4: bool) {
        0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::validate_market<T0>(arg1, arg2);
        assert!(!0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::has_circuit_break_triggered<T0>(arg2), 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::error::market_under_circuit_break());
        0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::change_operation_status<T0>(0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::market_asset_borrow_mut<T0, T1>(arg2), arg3, arg4);
        let v0 = AssetUpdated<bool>{
            what   : 2 + arg3,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg4,
        };
        0x2::event::emit<AssetUpdated<bool>>(v0);
    }

    public fun update_market_asset_config<T0, T1>(arg0: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::AdminCap, arg1: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::ProtocolApp, arg2: &mut 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::Market<T0>, arg3: 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::AssetConfig) {
        0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::validate_market<T0>(arg1, arg2);
        assert!(!0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::has_circuit_break_triggered<T0>(arg2), 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::error::market_under_circuit_break());
        0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::update_asset_config<T0>(0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::market_asset_borrow_mut<T0, T1>(arg2), arg3);
        let v0 = AssetUpdated<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::AssetConfig>{
            what   : 0,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::AssetConfig>>(v0);
    }

    public fun update_market_asset_interest_model<T0, T1>(arg0: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::AdminCap, arg1: &0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::ProtocolApp, arg2: &mut 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::Market<T0>, arg3: 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::interest::InterestModel) {
        0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::app::validate_market<T0>(arg1, arg2);
        assert!(!0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::has_circuit_break_triggered<T0>(arg2), 0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::error::market_under_circuit_break());
        0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::asset::update_interest_model<T0>(0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::market::market_asset_borrow_mut<T0, T1>(arg2), arg3);
        let v0 = AssetUpdated<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::interest::InterestModel>{
            what   : 1,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0x8703193cbd503df71464b7f89bf87a99a0ccffa3afc701caf799cd4292bcd741::interest::InterestModel>>(v0);
    }

    // decompiled from Move bytecode v6
}

