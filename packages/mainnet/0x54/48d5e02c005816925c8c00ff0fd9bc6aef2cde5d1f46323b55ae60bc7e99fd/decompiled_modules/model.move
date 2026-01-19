module 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model {
    struct RebaseFeeModel has key {
        id: 0x2::object::UID,
        base: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate,
        multiplier: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
    }

    struct ReservingFeeModel has key {
        id: 0x2::object::UID,
        multiplier: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
    }

    struct FundingFeeModel has key {
        id: 0x2::object::UID,
        multiplier: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        max: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate,
    }

    struct OiFundingModel has store, key {
        id: 0x2::object::UID,
        multiplier: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        exponent: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        max: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate,
    }

    public fun compute_funding_fee_rate(arg0: &FundingFeeModel, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::SDecimal, arg2: u64) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::srate::SRate {
        let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::to_rate(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul(arg0.multiplier, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::value(&arg1)));
        if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::gt(&v0, &arg0.max)) {
            v0 = arg0.max;
        };
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::srate::from_rate(!0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::is_positive(&arg1), 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::mul_with_u64(v0, arg2), 28800))
    }

    public fun compute_oi_funding_rate(arg0: &OiFundingModel, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg2: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg3: u64) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::srate::SRate {
        let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::add(arg1, arg2);
        if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::is_zero(&v0)) {
            return 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::srate::zero()
        };
        let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::div(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::pow_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::sub(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::from_decimal(true, arg1), 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::from_decimal(true, arg2)), 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::floor_u64(arg0.exponent)), 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::from_decimal(true, v0));
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::to_rate(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_rate(arg0.multiplier, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::to_rate(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::value(&v1))));
        if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::gt(&v2, &arg0.max)) {
            v2 = arg0.max;
        };
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::srate::from_rate(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::is_positive(&v1), 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::mul_with_u64(v2, arg3), 28800))
    }

    public fun compute_rebase_fee_rate(arg0: &RebaseFeeModel, arg1: bool, arg2: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg3: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate {
        if (arg1 && 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::le(&arg2, &arg3) || !arg1 && 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::ge(&arg2, &arg3)) {
            arg0.base
        } else {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::add(arg0.base, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::to_rate(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_rate(arg0.multiplier, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::diff(arg2, arg3))))
        }
    }

    public fun compute_reserving_fee_rate(arg0: &ReservingFeeModel, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg2: u64) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate {
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::mul_with_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::to_rate(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_rate(arg0.multiplier, arg1)), arg2), 28800)
    }

    public(friend) fun create_funding_fee_model(arg0: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        let v1 = FundingFeeModel{
            id         : v0,
            multiplier : arg0,
            max        : arg1,
        };
        0x2::transfer::share_object<FundingFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun create_oi_funding_model(arg0: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg2: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg3: &mut 0x2::tx_context::TxContext) : OiFundingModel {
        validate_funding_multiplier(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::to_raw(arg0));
        validate_exponent_raw(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::to_raw(arg1));
        OiFundingModel{
            id         : 0x2::object::new(arg3),
            multiplier : arg0,
            exponent   : arg1,
            max        : arg2,
        }
    }

    public(friend) fun create_rebase_fee_model(arg0: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        let v1 = RebaseFeeModel{
            id         : v0,
            base       : arg0,
            multiplier : arg1,
        };
        0x2::transfer::share_object<RebaseFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun create_reserving_fee_model(arg0: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg1);
        let v1 = ReservingFeeModel{
            id         : v0,
            multiplier : arg0,
        };
        0x2::transfer::share_object<ReservingFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public entry fun update_funding_fee_model(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut FundingFeeModel, arg2: u256, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.multiplier = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg2);
        arg1.max = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg3);
    }

    public(friend) fun update_oi_funding_model(arg0: &mut OiFundingModel, arg1: u256, arg2: u256, arg3: u128) {
        validate_funding_multiplier(arg1);
        validate_exponent_raw(arg2);
        arg0.multiplier = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg1);
        arg0.exponent = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg2);
        arg0.max = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg3);
    }

    public entry fun update_rebase_fee_model(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut RebaseFeeModel, arg2: u128, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.base = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg2);
        arg1.multiplier = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg3);
    }

    public entry fun update_reserving_fee_model(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut ReservingFeeModel, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.multiplier = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg2);
    }

    fun validate_base(arg0: u256) {
        assert!(arg0 >= 100000000000000 && arg0 <= 100000000000000000, 19001);
    }

    fun validate_exponent_raw(arg0: u256) {
        assert!(arg0 >= 1000000000000000000 && arg0 <= 10000000000000000000, 19004);
    }

    fun validate_funding_multiplier(arg0: u256) {
        assert!(arg0 >= 100000000000 && arg0 <= 100000000000000000, 19002);
    }

    fun validate_max_rate(arg0: u256) {
        assert!(arg0 >= 100000000000000 && arg0 <= 10000000000000000, 19003);
    }

    fun validate_multiplier(arg0: u256) {
        assert!(arg0 >= 100000000000000 && arg0 <= 100000000000000000, 19002);
    }

    // decompiled from Move bytecode v6
}

