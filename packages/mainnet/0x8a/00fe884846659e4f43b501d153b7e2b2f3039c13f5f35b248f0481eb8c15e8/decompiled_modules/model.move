module 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::model {
    struct RebaseFeeModel has key {
        id: 0x2::object::UID,
        base: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::Rate,
        multiplier: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::Decimal,
    }

    struct ReservingFeeModel has key {
        id: 0x2::object::UID,
        multiplier: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::Decimal,
    }

    struct FundingFeeModel has key {
        id: 0x2::object::UID,
        multiplier: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::Decimal,
        max: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::Rate,
    }

    public fun compute_funding_fee_rate(arg0: &FundingFeeModel, arg1: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::sdecimal::SDecimal, arg2: u64) : 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::srate::SRate {
        let v0 = 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::to_rate(0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::mul(arg0.multiplier, 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::sdecimal::value(&arg1)));
        if (0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::gt(&v0, &arg0.max)) {
            v0 = arg0.max;
        };
        0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::srate::from_rate(!0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::sdecimal::is_positive(&arg1), 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::div_by_u64(0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::mul_with_u64(v0, arg2), 28800))
    }

    public fun compute_rebase_fee_rate(arg0: &RebaseFeeModel, arg1: bool, arg2: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::Rate, arg3: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::Rate) : 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::Rate {
        if (arg1 && 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::lt(&arg2, &arg3) || !arg1 && 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::gt(&arg2, &arg3)) {
            arg0.base
        } else {
            0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::add(arg0.base, 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::to_rate(0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::mul_with_rate(arg0.multiplier, 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::diff(arg2, arg3))))
        }
    }

    public fun compute_reserving_fee_rate(arg0: &ReservingFeeModel, arg1: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::Rate, arg2: u64) : 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::Rate {
        0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::div_by_u64(0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::mul_with_u64(0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::to_rate(0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::mul_with_rate(arg0.multiplier, arg1)), arg2), 28800)
    }

    public(friend) fun create_funding_fee_model(arg0: u256, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        let v1 = FundingFeeModel{
            id         : v0,
            multiplier : 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::from_raw(arg0),
            max        : 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::from_raw(arg1),
        };
        0x2::transfer::share_object<FundingFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun create_rebase_fee_model(arg0: u128, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        let v1 = RebaseFeeModel{
            id         : v0,
            base       : 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::from_raw(arg0),
            multiplier : 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::from_raw(arg1),
        };
        0x2::transfer::share_object<RebaseFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun create_reserving_fee_model(arg0: u256, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg1);
        let v1 = ReservingFeeModel{
            id         : v0,
            multiplier : 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::decimal::from_raw(arg0),
        };
        0x2::transfer::share_object<ReservingFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    // decompiled from Move bytecode v6
}

