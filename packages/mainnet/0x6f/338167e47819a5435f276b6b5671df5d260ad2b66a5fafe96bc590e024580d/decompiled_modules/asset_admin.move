module 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset_admin {
    struct AssetOnboardedEvent has copy, drop {
        market: 0x1::type_name::TypeName,
        interest_model: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::interest::InterestModel,
        asset_config: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset::AssetConfig,
        time: u64,
        operator: address,
    }

    struct AssetUpdated<T0> has copy, drop {
        what: u8,
        market: 0x1::type_name::TypeName,
        asset: 0x1::type_name::TypeName,
        new: T0,
    }

    public fun create_interest_model(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::interest::InterestModel {
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::interest::new(0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::from_quotient(arg1, 1000000000000000000), 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::from_quotient(arg2, 1000000000000000000), 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::from_quotient(arg3, 10000), 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::from_quotient(arg4, 1000000000000000000), 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::from_quotient(arg5, 10000), 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::from_quotient(arg6, 1000000000000000000))
    }

    public fun create_market_asset_config(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset::AssetConfig {
        assert!(arg1 > 0, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::invalid_params_error());
        assert!(arg4 <= 10000, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::invalid_params_error());
        assert!(arg3 <= 10000, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::invalid_params_error());
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset::new_asset_config(arg1, 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::from_quotient(arg3, 10000), arg2, 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::from_quotient(arg4, 10000))
    }

    public fun onboard_new_asset<T0, T1>(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::AdminCap, arg1: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::ProtocolApp, arg2: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg3: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::interest::InterestModel, arg4: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset::AssetConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::has_circuit_break_triggered<T0>(arg2), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::market_under_circuit_break());
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::validate_market<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::onboard_new_asset<T0, T1>(arg2, arg3, arg4, v0, arg6);
        let v1 = AssetOnboardedEvent{
            market         : 0x1::type_name::get<T0>(),
            interest_model : arg3,
            asset_config   : arg4,
            time           : v0,
            operator       : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<AssetOnboardedEvent>(v1);
    }

    public fun update_asset_paused_state<T0, T1>(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::AdminCap, arg1: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::ProtocolApp, arg2: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg3: u8, arg4: bool) {
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::validate_market<T0>(arg1, arg2);
        assert!(!0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::has_circuit_break_triggered<T0>(arg2), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::market_under_circuit_break());
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset::change_operation_status<T0>(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::market_asset_borrow_mut<T0, T1>(arg2), arg3, arg4);
        let v0 = AssetUpdated<bool>{
            what   : 2 + arg3,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg4,
        };
        0x2::event::emit<AssetUpdated<bool>>(v0);
    }

    public fun update_market_asset_config<T0, T1>(arg0: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::AdminCap, arg1: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::ProtocolApp, arg2: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg3: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset::AssetConfig) {
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app::validate_market<T0>(arg1, arg2);
        assert!(!0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::has_circuit_break_triggered<T0>(arg2), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::market_under_circuit_break());
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset::update_asset_config<T0>(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::market_asset_borrow_mut<T0, T1>(arg2), arg3);
        let v0 = AssetUpdated<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset::AssetConfig>{
            what   : 1,
            market : 0x1::type_name::get<T0>(),
            asset  : 0x1::type_name::get<T1>(),
            new    : arg3,
        };
        0x2::event::emit<AssetUpdated<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::asset::AssetConfig>>(v0);
    }

    // decompiled from Move bytecode v6
}

