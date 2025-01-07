module 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::model {
    struct RebaseFeeModel has key {
        id: 0x2::object::UID,
        base: 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::Rate,
        multiplier: 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::decimal::Decimal,
    }

    struct ReservingFeeModel has key {
        id: 0x2::object::UID,
        multiplier: 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::decimal::Decimal,
    }

    struct FundingFeeModel has key {
        id: 0x2::object::UID,
        multiplier: 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::decimal::Decimal,
        max: 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::Rate,
    }

    public fun compute_funding_fee_rate(arg0: &FundingFeeModel, arg1: 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::sdecimal::SDecimal, arg2: u64) : 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::srate::SRate {
        let v0 = 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::decimal::to_rate(0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::decimal::mul(arg0.multiplier, 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::sdecimal::value(&arg1)));
        if (0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::gt(&v0, &arg0.max)) {
            v0 = arg0.max;
        };
        0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::srate::from_rate(!0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::sdecimal::is_positive(&arg1), 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::div_by_u64(0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::mul_with_u64(v0, arg2), 28800))
    }

    public fun compute_rebase_fee_rate(arg0: &RebaseFeeModel, arg1: bool, arg2: 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::Rate, arg3: 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::Rate) : 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::Rate {
        if (arg1 && 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::le(&arg2, &arg3) || !arg1 && 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::ge(&arg2, &arg3)) {
            arg0.base
        } else {
            0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::add(arg0.base, 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::decimal::to_rate(0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::decimal::mul_with_rate(arg0.multiplier, 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::diff(arg2, arg3))))
        }
    }

    public fun compute_reserving_fee_rate(arg0: &ReservingFeeModel, arg1: 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::Rate, arg2: u64) : 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::Rate {
        0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::div_by_u64(0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::mul_with_u64(0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::decimal::to_rate(0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::decimal::mul_with_rate(arg0.multiplier, arg1)), arg2), 28800)
    }

    public(friend) fun create_funding_fee_model(arg0: 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::decimal::Decimal, arg1: 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::Rate, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        let v1 = FundingFeeModel{
            id         : v0,
            multiplier : arg0,
            max        : arg1,
        };
        0x2::transfer::share_object<FundingFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun create_rebase_fee_model(arg0: 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::Rate, arg1: 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::decimal::Decimal, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        let v1 = RebaseFeeModel{
            id         : v0,
            base       : arg0,
            multiplier : arg1,
        };
        0x2::transfer::share_object<RebaseFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun create_reserving_fee_model(arg0: 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::decimal::Decimal, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg1);
        let v1 = ReservingFeeModel{
            id         : v0,
            multiplier : arg0,
        };
        0x2::transfer::share_object<ReservingFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    // decompiled from Move bytecode v6
}

