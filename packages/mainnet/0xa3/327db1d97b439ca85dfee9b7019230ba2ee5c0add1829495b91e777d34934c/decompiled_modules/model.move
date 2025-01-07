module 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::model {
    struct RebaseFeeModel has key {
        id: 0x2::object::UID,
        base: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::Rate,
        multiplier: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::Decimal,
    }

    struct ReservingFeeModel has key {
        id: 0x2::object::UID,
        multiplier: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::Decimal,
    }

    struct FundingFeeModel has key {
        id: 0x2::object::UID,
        multiplier: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::Decimal,
        max: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::Rate,
    }

    public fun compute_funding_fee_rate(arg0: &FundingFeeModel, arg1: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::sdecimal::SDecimal, arg2: u64) : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::srate::SRate {
        let v0 = 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::to_rate(0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::mul(arg0.multiplier, 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::sdecimal::value(&arg1)));
        if (0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::gt(&v0, &arg0.max)) {
            v0 = arg0.max;
        };
        0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::srate::from_rate(!0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::sdecimal::is_positive(&arg1), 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::div_by_u64(0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::mul_with_u64(v0, arg2), 28800))
    }

    public fun compute_rebase_fee_rate(arg0: &RebaseFeeModel, arg1: bool, arg2: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::Rate, arg3: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::Rate) : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::Rate {
        if (arg1 && 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::lt(&arg2, &arg3) || !arg1 && 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::gt(&arg2, &arg3)) {
            arg0.base
        } else {
            0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::add(arg0.base, 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::to_rate(0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::mul_with_rate(arg0.multiplier, 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::diff(arg2, arg3))))
        }
    }

    public fun compute_reserving_fee_rate(arg0: &ReservingFeeModel, arg1: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::Rate, arg2: u64) : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::Rate {
        0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::div_by_u64(0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::mul_with_u64(0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::to_rate(0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::mul_with_rate(arg0.multiplier, arg1)), arg2), 28800)
    }

    public(friend) fun create_funding_fee_model(arg0: u256, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        let v1 = FundingFeeModel{
            id         : v0,
            multiplier : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::from_raw(arg0),
            max        : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::from_raw(arg1),
        };
        0x2::transfer::share_object<FundingFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun create_rebase_fee_model(arg0: u128, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        let v1 = RebaseFeeModel{
            id         : v0,
            base       : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::from_raw(arg0),
            multiplier : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::from_raw(arg1),
        };
        0x2::transfer::share_object<RebaseFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun create_reserving_fee_model(arg0: u256, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg1);
        let v1 = ReservingFeeModel{
            id         : v0,
            multiplier : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::decimal::from_raw(arg0),
        };
        0x2::transfer::share_object<ReservingFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    // decompiled from Move bytecode v6
}

