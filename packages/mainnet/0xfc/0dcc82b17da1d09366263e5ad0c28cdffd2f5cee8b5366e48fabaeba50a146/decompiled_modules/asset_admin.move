module 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::asset_admin {
    struct AssetOnboardedEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        interest_model: 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::interest::InterestModel,
        asset_config: 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::asset::AssetConfig,
        time: u64,
        operator: address,
    }

    struct AssetUpdated<T0> has copy, drop {
        what: u8,
        market: 0x1::type_name::TypeName,
        asset: 0x1::type_name::TypeName,
        new: T0,
    }

    public fun create_interest_model(arg0: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::interest::InterestModel {
        assert!(arg3 > 0, 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::error::invalid_params_error());
        assert!(arg3 < arg5 && arg5 < 10000, 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::error::invalid_params_error());
        assert!(arg1 <= arg2, 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::error::invalid_params_error());
        assert!(arg2 <= arg4 && arg4 <= arg6, 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::error::invalid_params_error());
        create_interest_model_inner(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    fun create_interest_model_inner(arg0: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::interest::InterestModel {
        0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::interest::new(0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::from_quotient(arg1, 1000000000000000000), 0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::from_quotient(arg2, 1000000000000000000), 0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::from_quotient(arg3, 10000), 0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::from_quotient(arg4, 1000000000000000000), 0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::from_quotient(arg5, 10000), 0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::from_quotient(arg6, 1000000000000000000))
    }

    public fun create_market_asset_config(arg0: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::asset::AssetConfig {
        assert!(arg1 > 0, 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::error::invalid_params_error());
        assert!(arg4 <= 10000, 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::error::invalid_params_error());
        assert!(arg3 <= 10000, 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::error::invalid_params_error());
        0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::asset::new_asset_config(arg1, 0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::from_quotient(arg3, 10000), arg2, 0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::from_quotient(arg4, 10000))
    }

    public fun onboard_new_asset<T0, T1>(arg0: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::AdminCap, arg1: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::ProtocolApp, arg2: &mut 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::Market<T0>, arg3: 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::interest::InterestModel, arg4: 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::asset::AssetConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::has_circuit_break_triggered<T0>(arg2), 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::error::market_under_circuit_break());
        0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::validate_market<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::onboard_new_asset<T0, T1>(arg2, arg3, arg4, v0, arg6);
        let v1 = AssetOnboardedEvent{
            market         : 0x1::type_name::get<T0>(),
            interest_model : arg3,
            asset_config   : arg4,
            time           : v0,
            operator       : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<AssetOnboardedEvent>(v1);
    }

    public fun update_asset_paused_state<T0, T1>(arg0: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::AdminCap, arg1: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::ProtocolApp, arg2: &mut 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::Market<T0>, arg3: u8, arg4: bool) {
        0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::validate_market<T0>(arg1, arg2);
        assert!(!0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::has_circuit_break_triggered<T0>(arg2), 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::error::market_under_circuit_break());
        0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::asset::change_operation_status<T0>(0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::market_asset_borrow_mut<T0, T1>(arg2), arg3, arg4);
        let v0 = AssetUpdated<bool>{
            what   : 2 + arg3,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg4,
        };
        0x2::event::emit<AssetUpdated<bool>>(v0);
    }

    public fun update_market_asset_config<T0, T1>(arg0: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::AdminCap, arg1: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::ProtocolApp, arg2: &mut 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::Market<T0>, arg3: 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::asset::AssetConfig) {
        0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::validate_market<T0>(arg1, arg2);
        assert!(!0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::has_circuit_break_triggered<T0>(arg2), 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::error::market_under_circuit_break());
        0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::asset::update_asset_config<T0>(0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::market_asset_borrow_mut<T0, T1>(arg2), arg3);
        let v0 = AssetUpdated<0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::asset::AssetConfig>{
            what   : 0,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::asset::AssetConfig>>(v0);
    }

    public fun update_market_asset_interest_model<T0, T1>(arg0: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::AdminCap, arg1: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::ProtocolApp, arg2: &mut 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::Market<T0>, arg3: 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::interest::InterestModel) {
        0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::validate_market<T0>(arg1, arg2);
        assert!(!0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::has_circuit_break_triggered<T0>(arg2), 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::error::market_under_circuit_break());
        0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::asset::update_interest_model<T0>(0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::market_asset_borrow_mut<T0, T1>(arg2), arg3);
        let v0 = AssetUpdated<0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::interest::InterestModel>{
            what   : 1,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::interest::InterestModel>>(v0);
    }

    // decompiled from Move bytecode v6
}

