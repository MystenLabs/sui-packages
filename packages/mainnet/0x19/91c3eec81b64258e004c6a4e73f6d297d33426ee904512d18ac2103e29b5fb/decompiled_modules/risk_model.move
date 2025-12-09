module 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::risk_model {
    struct RiskModels has drop {
        dummy_field: bool,
    }

    struct RiskModel has copy, drop, store {
        type_name: 0x1::type_name::TypeName,
        collateral_factor: 0x1::fixed_point32::FixedPoint32,
        liquidation_factor: 0x1::fixed_point32::FixedPoint32,
        liquidation_penalty: 0x1::fixed_point32::FixedPoint32,
        liquidation_discount: 0x1::fixed_point32::FixedPoint32,
        liquidation_revenue_factor: 0x1::fixed_point32::FixedPoint32,
        max_collateral_amount: u64,
    }

    struct RiskModelChangeCreated has copy, drop {
        risk_model: RiskModel,
        current_epoch: u64,
        delay_epoches: u64,
        effective_epoches: u64,
    }

    struct RiskModelAdded has copy, drop {
        risk_model: RiskModel,
        current_epoch: u64,
    }

    public fun type_name(arg0: &RiskModel) : 0x1::type_name::TypeName {
        arg0.type_name
    }

    public(friend) fun add_risk_model<T0>(arg0: &mut 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::ac_table::AcTable<RiskModels, 0x1::type_name::TypeName, RiskModel>, arg1: &0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::ac_table::AcTableCap<RiskModels>, arg2: 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::one_time_lock_value::OneTimeLockValue<RiskModel>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::one_time_lock_value::get_value<RiskModel>(arg2, arg3);
        let v1 = 0x1::type_name::get<T0>();
        assert!(v0.type_name == v1, 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::risk_model_type_not_match_error());
        if (0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::ac_table::contains<RiskModels, 0x1::type_name::TypeName, RiskModel>(arg0, v1)) {
            0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::ac_table::remove<RiskModels, 0x1::type_name::TypeName, RiskModel>(arg0, arg1, v1);
        };
        0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::ac_table::add<RiskModels, 0x1::type_name::TypeName, RiskModel>(arg0, arg1, v1, v0);
        let v2 = RiskModelAdded{
            risk_model    : v0,
            current_epoch : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<RiskModelAdded>(v2);
    }

    public fun collateral_factor(arg0: &RiskModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.collateral_factor
    }

    public(friend) fun create_risk_model_change<T0>(arg0: &0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::ac_table::AcTableCap<RiskModels>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::one_time_lock_value::OneTimeLockValue<RiskModel> {
        let v0 = 0x1::fixed_point32::create_from_rational(arg1, arg5);
        assert!(0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::gt(v0, 0x1::fixed_point32::create_from_rational(95, 100)) == false, 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::risk_model_param_error());
        let v1 = 0x1::fixed_point32::create_from_rational(arg2, arg5);
        assert!(0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::gt(v1, 0x1::fixed_point32::create_from_rational(95, 100)) == false, 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::risk_model_param_error());
        let v2 = 0x1::fixed_point32::create_from_rational(arg3, arg5);
        assert!(0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::gt(v2, 0x1::fixed_point32::create_from_rational(20, 100)) == false, 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::risk_model_param_error());
        let v3 = 0x1::fixed_point32::create_from_rational(arg4, arg5);
        assert!(0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::gt(v3, 0x1::fixed_point32::create_from_rational(15, 100)) == false, 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::risk_model_param_error());
        assert!(0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::gt(v1, v0), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::risk_model_param_error());
        assert!(0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::gt(v2, v3), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::risk_model_param_error());
        assert!(0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::gt(0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::sub(v1, v0), 0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::add(v2, v3)), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::risk_model_param_error());
        assert!(0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::gt(0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::sub(0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::from_u64(1), v2), v1), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::risk_model_param_error());
        let v4 = RiskModel{
            type_name                  : 0x1::type_name::get<T0>(),
            collateral_factor          : v0,
            liquidation_factor         : v1,
            liquidation_penalty        : v2,
            liquidation_discount       : v3,
            liquidation_revenue_factor : 0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::sub(v2, v3),
            max_collateral_amount      : arg6,
        };
        let v5 = RiskModelChangeCreated{
            risk_model        : v4,
            current_epoch     : 0x2::tx_context::epoch(arg8),
            delay_epoches     : arg7,
            effective_epoches : 0x2::tx_context::epoch(arg8) + arg7,
        };
        0x2::event::emit<RiskModelChangeCreated>(v5);
        0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::one_time_lock_value::new<RiskModel>(v4, arg7, 7, arg8)
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

    public fun max_collateral_amount(arg0: &RiskModel) : u64 {
        arg0.max_collateral_amount
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::ac_table::AcTable<RiskModels, 0x1::type_name::TypeName, RiskModel>, 0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::ac_table::AcTableCap<RiskModels>) {
        let v0 = RiskModels{dummy_field: false};
        0xce486acf40cc74f66c62779641ba0d7ca1d55c8ab51c6d79abbdec6bfe4ba6fa::ac_table::new<RiskModels, 0x1::type_name::TypeName, RiskModel>(v0, true, arg0)
    }

    // decompiled from Move bytecode v6
}

