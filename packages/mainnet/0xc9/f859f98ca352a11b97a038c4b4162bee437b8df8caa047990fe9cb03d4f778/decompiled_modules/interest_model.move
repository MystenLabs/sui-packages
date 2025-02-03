module 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::interest_model {
    struct InterestModel has copy, drop, store {
        type: 0x1::type_name::TypeName,
        base_borrow_rate_per_sec: 0x1::fixed_point32::FixedPoint32,
        interest_rate_scale: u64,
        borrow_rate_on_mid_kink: 0x1::fixed_point32::FixedPoint32,
        mid_kink: 0x1::fixed_point32::FixedPoint32,
        borrow_rate_on_high_kink: 0x1::fixed_point32::FixedPoint32,
        high_kink: 0x1::fixed_point32::FixedPoint32,
        max_borrow_rate: 0x1::fixed_point32::FixedPoint32,
        revenue_factor: 0x1::fixed_point32::FixedPoint32,
        borrow_weight: 0x1::fixed_point32::FixedPoint32,
        min_borrow_amount: u64,
    }

    struct InterestModelChangeCreated has copy, drop {
        interest_model: InterestModel,
        current_epoch: u64,
        delay_epoches: u64,
        effective_epoches: u64,
    }

    struct InterestModelAdded has copy, drop {
        interest_model: InterestModel,
        current_epoch: u64,
    }

    struct InterestModels has drop {
        dummy_field: bool,
    }

    public fun type_name(arg0: &InterestModel) : 0x1::type_name::TypeName {
        arg0.type
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTable<InterestModels, 0x1::type_name::TypeName, InterestModel>, 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTableCap<InterestModels>) {
        let v0 = InterestModels{dummy_field: false};
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::new<InterestModels, 0x1::type_name::TypeName, InterestModel>(v0, true, arg0)
    }

    public(friend) fun add_interest_model<T0>(arg0: &mut 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTable<InterestModels, 0x1::type_name::TypeName, InterestModel>, arg1: &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTableCap<InterestModels>, arg2: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::OneTimeLockValue<InterestModel>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::get_value<InterestModel>(arg2, arg3);
        let v1 = 0x1::type_name::get<T0>();
        assert!(v0.type == v1, 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::error::interest_model_type_not_match_error());
        if (0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::contains<InterestModels, 0x1::type_name::TypeName, InterestModel>(arg0, v1)) {
            0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::remove<InterestModels, 0x1::type_name::TypeName, InterestModel>(arg0, arg1, v1);
        };
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::add<InterestModels, 0x1::type_name::TypeName, InterestModel>(arg0, arg1, v1, v0);
        let v2 = InterestModelAdded{
            interest_model : v0,
            current_epoch  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<InterestModelAdded>(v2);
    }

    public fun base_borrow_rate(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.base_borrow_rate_per_sec
    }

    public fun borrow_rate_on_high_kink(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.borrow_rate_on_high_kink
    }

    public fun borrow_rate_on_mid_kink(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.borrow_rate_on_mid_kink
    }

    public fun borrow_weight(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.borrow_weight
    }

    public fun calc_interest(arg0: &InterestModel, arg1: 0x1::fixed_point32::FixedPoint32) : (0x1::fixed_point32::FixedPoint32, u64) {
        let v0 = arg0.borrow_rate_on_mid_kink;
        let v1 = arg0.mid_kink;
        let v2 = arg0.borrow_rate_on_high_kink;
        let v3 = arg0.high_kink;
        let v4 = arg0.base_borrow_rate_per_sec;
        let v5 = if (0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gte(v1, arg1)) {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::add(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(arg1, v1), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(v0, v4)), v4)
        } else if (0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gte(v3, arg1)) {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::add(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(arg1, v1), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(v3, v1)), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(v2, v0)), v0)
        } else {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::add(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(arg1, v3), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::from_u64(1), v3)), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(arg0.max_borrow_rate, v2)), v2)
        };
        (v5, arg0.interest_rate_scale)
    }

    public(friend) fun create_interest_model_change<T0>(arg0: &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTableCap<InterestModels>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::OneTimeLockValue<InterestModel> {
        assert!(arg4 <= arg6, 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::error::interest_model_param_error());
        assert!(arg1 <= arg3, 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::error::interest_model_param_error());
        assert!(arg3 <= arg5, 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::error::interest_model_param_error());
        assert!(arg5 <= arg7, 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::error::interest_model_param_error());
        let v0 = InterestModel{
            type                     : 0x1::type_name::get<T0>(),
            base_borrow_rate_per_sec : 0x1::fixed_point32::create_from_rational(arg1, arg10),
            interest_rate_scale      : arg2,
            borrow_rate_on_mid_kink  : 0x1::fixed_point32::create_from_rational(arg3, arg10),
            mid_kink                 : 0x1::fixed_point32::create_from_rational(arg4, arg10),
            borrow_rate_on_high_kink : 0x1::fixed_point32::create_from_rational(arg5, arg10),
            high_kink                : 0x1::fixed_point32::create_from_rational(arg6, arg10),
            max_borrow_rate          : 0x1::fixed_point32::create_from_rational(arg7, arg10),
            revenue_factor           : 0x1::fixed_point32::create_from_rational(arg8, arg10),
            borrow_weight            : 0x1::fixed_point32::create_from_rational(arg9, arg10),
            min_borrow_amount        : arg11,
        };
        let v1 = InterestModelChangeCreated{
            interest_model    : v0,
            current_epoch     : 0x2::tx_context::epoch(arg13),
            delay_epoches     : arg12,
            effective_epoches : 0x2::tx_context::epoch(arg13) + arg12,
        };
        0x2::event::emit<InterestModelChangeCreated>(v1);
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::new<InterestModel>(v0, arg12, 7, arg13)
    }

    public fun high_kink(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.high_kink
    }

    public fun interest_rate_scale(arg0: &InterestModel) : u64 {
        arg0.interest_rate_scale
    }

    public fun max_borrow_rate(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.max_borrow_rate
    }

    public fun mid_kink(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.mid_kink
    }

    public fun min_borrow_amount(arg0: &InterestModel) : u64 {
        arg0.min_borrow_amount
    }

    public fun revenue_factor(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.revenue_factor
    }

    // decompiled from Move bytecode v6
}

