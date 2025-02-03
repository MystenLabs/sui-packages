module 0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::interest_model {
    struct InterestModel has copy, drop, store {
        type: 0x1::type_name::TypeName,
        base_borrow_rate_per_sec: 0x1::fixed_point32::FixedPoint32,
        interest_rate_scale: u64,
        low_slope: 0x1::fixed_point32::FixedPoint32,
        kink: 0x1::fixed_point32::FixedPoint32,
        high_slope: 0x1::fixed_point32::FixedPoint32,
        revenue_factor: 0x1::fixed_point32::FixedPoint32,
        min_borrow_amount: u64,
        borrow_weight: 0x1::fixed_point32::FixedPoint32,
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

    public(friend) fun add_interest_model<T0>(arg0: &mut 0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::ac_table::AcTable<InterestModels, 0x1::type_name::TypeName, InterestModel>, arg1: &0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::ac_table::AcTableCap<InterestModels>, arg2: 0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::one_time_lock_value::OneTimeLockValue<InterestModel>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::one_time_lock_value::get_value<InterestModel>(arg2, arg3);
        let v1 = 0x1::type_name::get<T0>();
        assert!(v0.type == v1, 0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::error::interest_model_type_not_match_error());
        if (0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::ac_table::contains<InterestModels, 0x1::type_name::TypeName, InterestModel>(arg0, v1)) {
            0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::ac_table::remove<InterestModels, 0x1::type_name::TypeName, InterestModel>(arg0, arg1, v1);
        };
        0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::ac_table::add<InterestModels, 0x1::type_name::TypeName, InterestModel>(arg0, arg1, v1, v0);
        let v2 = InterestModelAdded{
            interest_model : v0,
            current_epoch  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<InterestModelAdded>(v2);
    }

    public fun base_borrow_rate(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.base_borrow_rate_per_sec
    }

    public fun borrow_weight(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.borrow_weight
    }

    public fun calc_interest(arg0: &InterestModel, arg1: 0x1::fixed_point32::FixedPoint32) : (0x1::fixed_point32::FixedPoint32, u64) {
        let v0 = arg0.kink;
        let v1 = if (0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::gt(arg1, v0)) {
            0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::add(0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::mul(v0, arg0.low_slope), 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::mul(0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::sub(arg1, v0), arg0.high_slope))
        } else {
            0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::mul(arg1, arg0.low_slope)
        };
        (0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::mul(arg0.base_borrow_rate_per_sec, 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::add(0x1::fixed_point32::create_from_rational(1, 1), v1)), arg0.interest_rate_scale)
    }

    public(friend) fun create_interest_model_change<T0>(arg0: &0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::ac_table::AcTableCap<InterestModels>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : 0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::one_time_lock_value::OneTimeLockValue<InterestModel> {
        let v0 = InterestModel{
            type                     : 0x1::type_name::get<T0>(),
            base_borrow_rate_per_sec : 0x1::fixed_point32::create_from_rational(arg1, arg7),
            interest_rate_scale      : arg2,
            low_slope                : 0x1::fixed_point32::create_from_rational(arg3, arg7),
            kink                     : 0x1::fixed_point32::create_from_rational(arg4, arg7),
            high_slope               : 0x1::fixed_point32::create_from_rational(arg5, arg7),
            revenue_factor           : 0x1::fixed_point32::create_from_rational(arg6, arg7),
            min_borrow_amount        : arg8,
            borrow_weight            : 0x1::fixed_point32::create_from_rational(arg9, arg7),
        };
        let v1 = InterestModelChangeCreated{
            interest_model    : v0,
            current_epoch     : 0x2::tx_context::epoch(arg11),
            delay_epoches     : arg10,
            effective_epoches : 0x2::tx_context::epoch(arg11) + arg10,
        };
        0x2::event::emit<InterestModelChangeCreated>(v1);
        0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::one_time_lock_value::new<InterestModel>(v0, arg10, 7, arg11)
    }

    public fun high_slope(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.high_slope
    }

    public fun interest_rate_scale(arg0: &InterestModel) : u64 {
        arg0.interest_rate_scale
    }

    public fun kink(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.kink
    }

    public fun low_slope(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.low_slope
    }

    public fun min_borrow_amount(arg0: &InterestModel) : u64 {
        arg0.min_borrow_amount
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::ac_table::AcTable<InterestModels, 0x1::type_name::TypeName, InterestModel>, 0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::ac_table::AcTableCap<InterestModels>) {
        let v0 = InterestModels{dummy_field: false};
        0xfd1248585e5fcc31620aeab61fa030e73ea385a98bb8c0f0068f427d9ddfde5c::ac_table::new<InterestModels, 0x1::type_name::TypeName, InterestModel>(v0, true, arg0)
    }

    public fun revenue_factor(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.revenue_factor
    }

    // decompiled from Move bytecode v6
}

