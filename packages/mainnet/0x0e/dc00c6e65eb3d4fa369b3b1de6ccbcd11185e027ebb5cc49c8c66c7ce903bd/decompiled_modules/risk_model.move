module 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::risk_model {
    struct RiskModels has drop {
        dummy_field: bool,
    }

    struct RiskModel has copy, drop, store {
        type: 0x1::type_name::TypeName,
        collateral_factor: 0x1::fixed_point32::FixedPoint32,
        liquidation_factor: 0x1::fixed_point32::FixedPoint32,
        liquidation_penalty: 0x1::fixed_point32::FixedPoint32,
        liquidation_discount: 0x1::fixed_point32::FixedPoint32,
        liquidation_revenue_factor: 0x1::fixed_point32::FixedPoint32,
        max_collateral_amount: u64,
    }

    public fun type_name(arg0: &RiskModel) : 0x1::type_name::TypeName {
        arg0.type
    }

    public(friend) fun add_risk_model<T0>(arg0: &mut 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTable<RiskModels, 0x1::type_name::TypeName, RiskModel>, arg1: &0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTableCap<RiskModels>, arg2: 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::one_time_lock_value::OneTimeLockValue<RiskModel>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::one_time_lock_value::get_value<RiskModel>(arg2, arg3);
        let v1 = 0x1::type_name::get<T0>();
        assert!(v0.type == v1, 0xedc00c6e65eb3d4fa369b3b1de6ccbcd11185e027ebb5cc49c8c66c7ce903bd::error::risk_model_type_not_match_error());
        if (0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::contains<RiskModels, 0x1::type_name::TypeName, RiskModel>(arg0, v1)) {
            0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::remove<RiskModels, 0x1::type_name::TypeName, RiskModel>(arg0, arg1, v1);
        };
        0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::add<RiskModels, 0x1::type_name::TypeName, RiskModel>(arg0, arg1, 0x1::type_name::get<T0>(), v0);
    }

    public fun collateral_factor(arg0: &RiskModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.collateral_factor
    }

    public(friend) fun create_risk_model_change<T0>(arg0: &0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTableCap<RiskModels>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::one_time_lock_value::OneTimeLockValue<RiskModel> {
        let v0 = 0x1::fixed_point32::create_from_rational(arg3, arg5);
        let v1 = 0x1::fixed_point32::create_from_rational(arg4, arg5);
        let v2 = RiskModel{
            type                       : 0x1::type_name::get<T0>(),
            collateral_factor          : 0x1::fixed_point32::create_from_rational(arg1, arg5),
            liquidation_factor         : 0x1::fixed_point32::create_from_rational(arg2, arg5),
            liquidation_penalty        : v0,
            liquidation_discount       : v1,
            liquidation_revenue_factor : 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::sub(v0, v1),
            max_collateral_amount      : arg6,
        };
        0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::one_time_lock_value::new<RiskModel>(v2, arg7, 7, arg8)
    }

    public fun liq_discount(arg0: &RiskModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.liquidation_discount
    }

    public fun liq_factor(arg0: &RiskModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.liquidation_factor
    }

    public fun liq_penalty(arg0: &RiskModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.liquidation_penalty
    }

    public fun liq_revenue_factor(arg0: &RiskModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.liquidation_revenue_factor
    }

    public fun max_collateral_Amount(arg0: &RiskModel) : u64 {
        arg0.max_collateral_amount
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTable<RiskModels, 0x1::type_name::TypeName, RiskModel>, 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTableCap<RiskModels>) {
        let v0 = RiskModels{dummy_field: false};
        0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::new<RiskModels, 0x1::type_name::TypeName, RiskModel>(v0, true, arg0)
    }

    // decompiled from Move bytecode v6
}

