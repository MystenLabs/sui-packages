module 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::interest_model {
    struct InterestModel has copy, drop, store {
        type: 0x1::type_name::TypeName,
        base_borrow_rate_per_sec: 0x1::fixed_point32::FixedPoint32,
        low_slope: 0x1::fixed_point32::FixedPoint32,
        kink: 0x1::fixed_point32::FixedPoint32,
        high_slope: 0x1::fixed_point32::FixedPoint32,
        revenue_factor: 0x1::fixed_point32::FixedPoint32,
        min_borrow_amount: u64,
        borrow_weight: 0x1::fixed_point32::FixedPoint32,
    }

    struct InterestModels has drop {
        dummy_field: bool,
    }

    public fun type_name(arg0: &InterestModel) : 0x1::type_name::TypeName {
        arg0.type
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTable<InterestModels, 0x1::type_name::TypeName, InterestModel>, 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTableCap<InterestModels>) {
        let v0 = InterestModels{dummy_field: false};
        0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::new<InterestModels, 0x1::type_name::TypeName, InterestModel>(v0, true, arg0)
    }

    public(friend) fun add_interest_model<T0>(arg0: &mut 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTable<InterestModels, 0x1::type_name::TypeName, InterestModel>, arg1: &0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTableCap<InterestModels>, arg2: 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::one_time_lock_value::OneTimeLockValue<InterestModel>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::one_time_lock_value::get_value<InterestModel>(arg2, arg3);
        let v1 = 0x1::type_name::get<T0>();
        assert!(v0.type == v1, 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::error::interest_model_type_not_match_error());
        if (0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::contains<InterestModels, 0x1::type_name::TypeName, InterestModel>(arg0, v1)) {
            0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::remove<InterestModels, 0x1::type_name::TypeName, InterestModel>(arg0, arg1, v1);
        };
        0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::add<InterestModels, 0x1::type_name::TypeName, InterestModel>(arg0, arg1, v1, v0);
    }

    public fun base_borrow_rate(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.base_borrow_rate_per_sec
    }

    public fun base_borrow_rate_scale() : u64 {
        1000
    }

    public fun borrow_weight(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.borrow_weight
    }

    public fun calc_interest(arg0: &InterestModel, arg1: 0x1::fixed_point32::FixedPoint32) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = arg0.kink;
        let v1 = if (0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::gt(arg1, v0)) {
            0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::add(0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::mul(v0, arg0.low_slope), 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::mul(0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::sub(arg1, v0), arg0.high_slope))
        } else {
            0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::mul(arg1, arg0.low_slope)
        };
        0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::mul(arg0.base_borrow_rate_per_sec, 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::add(0x1::fixed_point32::create_from_rational(1, 1), v1))
    }

    public(friend) fun create_interest_model_change<T0>(arg0: &0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTableCap<InterestModels>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::one_time_lock_value::OneTimeLockValue<InterestModel> {
        let v0 = InterestModel{
            type                     : 0x1::type_name::get<T0>(),
            base_borrow_rate_per_sec : 0x1::fixed_point32::create_from_rational(arg1, arg6),
            low_slope                : 0x1::fixed_point32::create_from_rational(arg2, arg6),
            kink                     : 0x1::fixed_point32::create_from_rational(arg3, arg6),
            high_slope               : 0x1::fixed_point32::create_from_rational(arg4, arg6),
            revenue_factor           : 0x1::fixed_point32::create_from_rational(arg5, arg6),
            min_borrow_amount        : arg7,
            borrow_weight            : 0x1::fixed_point32::create_from_rational(arg8, arg6),
        };
        0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::one_time_lock_value::new<InterestModel>(v0, arg9, 7, arg10)
    }

    public fun high_slope(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.high_slope
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

    public fun revenue_factor(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.revenue_factor
    }

    // decompiled from Move bytecode v6
}

