module 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::model {
    struct RebaseFeeModel has key {
        id: 0x2::object::UID,
        base: 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::Rate,
        multiplier: 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::decimal::Decimal,
    }

    struct ReservingFeeModel has key {
        id: 0x2::object::UID,
        multiplier: 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::decimal::Decimal,
    }

    struct FundingFeeModel has key {
        id: 0x2::object::UID,
        multiplier: 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::decimal::Decimal,
        max: 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::Rate,
    }

    public fun compute_funding_fee_rate(arg0: &FundingFeeModel, arg1: 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::sdecimal::SDecimal, arg2: u64) : 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::srate::SRate {
        let v0 = 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::decimal::to_rate(0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::decimal::mul(arg0.multiplier, 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::sdecimal::value(&arg1)));
        if (0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::gt(&v0, &arg0.max)) {
            v0 = arg0.max;
        };
        0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::srate::from_rate(!0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::sdecimal::is_positive(&arg1), 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::div_by_u64(0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::mul_with_u64(v0, arg2), 28800))
    }

    public fun compute_rebase_fee_rate(arg0: &RebaseFeeModel, arg1: bool, arg2: 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::Rate, arg3: 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::Rate) : 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::Rate {
        if (arg1 && 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::le(&arg2, &arg3) || !arg1 && 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::ge(&arg2, &arg3)) {
            arg0.base
        } else {
            0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::add(arg0.base, 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::decimal::to_rate(0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::decimal::mul_with_rate(arg0.multiplier, 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::diff(arg2, arg3))))
        }
    }

    public fun compute_reserving_fee_rate(arg0: &ReservingFeeModel, arg1: 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::Rate, arg2: u64) : 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::Rate {
        0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::div_by_u64(0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::mul_with_u64(0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::decimal::to_rate(0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::decimal::mul_with_rate(arg0.multiplier, arg1)), arg2), 28800)
    }

    public(friend) fun create_funding_fee_model(arg0: 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::decimal::Decimal, arg1: 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::Rate, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        let v1 = FundingFeeModel{
            id         : v0,
            multiplier : arg0,
            max        : arg1,
        };
        0x2::transfer::share_object<FundingFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun create_rebase_fee_model(arg0: 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::Rate, arg1: 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::decimal::Decimal, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        let v1 = RebaseFeeModel{
            id         : v0,
            base       : arg0,
            multiplier : arg1,
        };
        0x2::transfer::share_object<RebaseFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun create_reserving_fee_model(arg0: 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::decimal::Decimal, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg1);
        let v1 = ReservingFeeModel{
            id         : v0,
            multiplier : arg0,
        };
        0x2::transfer::share_object<ReservingFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public entry fun update_funding_fee_model(arg0: &0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::admin::AdminCap, arg1: &mut FundingFeeModel, arg2: u256, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.multiplier = 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::decimal::from_raw(arg2);
        arg1.max = 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::from_raw(arg3);
    }

    public entry fun update_rebase_fee_model(arg0: &0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::admin::AdminCap, arg1: &mut RebaseFeeModel, arg2: u128, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.base = 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::from_raw(arg2);
        arg1.multiplier = 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::decimal::from_raw(arg3);
    }

    public entry fun update_reserving_fee_model(arg0: &0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::admin::AdminCap, arg1: &mut ReservingFeeModel, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.multiplier = 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::decimal::from_raw(arg2);
    }

    // decompiled from Move bytecode v6
}

