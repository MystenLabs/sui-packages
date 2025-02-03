module 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::risk_model {
    struct RiskModel has copy, drop, store {
        asset_type: 0x1::type_name::TypeName,
        collateral_pct: 0x1::fixed_point32::FixedPoint32,
        liquidation_pct: 0x1::fixed_point32::FixedPoint32,
    }

    struct RiskConfig has store {
        dummy_field: bool,
    }

    public fun get_asset_type(arg0: &RiskModel) : 0x1::type_name::TypeName {
        arg0.asset_type
    }

    public fun get_collateral_pct(arg0: &RiskModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.collateral_pct
    }

    public fun get_liquidation_pct(arg0: &RiskModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.liquidation_pct
    }

    public fun get_risk_model(arg0: &0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::TableKeys<0x1::type_name::TypeName, RiskModel>, arg1: 0x1::type_name::TypeName) : &RiskModel {
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::borrow_table<0x1::type_name::TypeName, RiskModel>(arg0, arg1)
    }

    public(friend) fun initialize_risk_model_table(arg0: &mut 0x2::tx_context::TxContext) : 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::TableKeys<0x1::type_name::TypeName, RiskModel> {
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::new<0x1::type_name::TypeName, RiskModel>(arg0)
    }

    public(friend) fun update_risk_model<T0>(arg0: &mut 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::TableKeys<0x1::type_name::TypeName, RiskModel>, arg1: u64, arg2: u64) {
        let v0 = 0x1::fixed_point32::create_from_rational(arg1, 100);
        let v1 = 0x1::fixed_point32::create_from_rational(arg2, 100);
        assert!(0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::f32::is_greater_than(v0, 0x1::fixed_point32::create_from_rational(95, 100)) == false, 0);
        assert!(0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::f32::is_greater_than(v1, 0x1::fixed_point32::create_from_rational(95, 100)) == false, 0);
        assert!(0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::f32::is_greater_than(v1, v0), 0);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = RiskModel{
            asset_type      : v2,
            collateral_pct  : v0,
            liquidation_pct : v1,
        };
        if (0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::is_present<0x1::type_name::TypeName, RiskModel>(arg0, v2)) {
            0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::delete<0x1::type_name::TypeName, RiskModel>(arg0, v2);
        };
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::add_key_value_pair<0x1::type_name::TypeName, RiskModel>(arg0, v2, v3);
    }

    // decompiled from Move bytecode v6
}

