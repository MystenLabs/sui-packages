module 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::model {
    struct RebaseFeeModel has key {
        id: 0x2::object::UID,
        base: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::Rate,
        multiplier: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::decimal::Decimal,
    }

    struct ReservingFeeModel has key {
        id: 0x2::object::UID,
        multiplier: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::decimal::Decimal,
    }

    struct FundingFeeModel has key {
        id: 0x2::object::UID,
        multiplier: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::decimal::Decimal,
        max: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::Rate,
    }

    public fun compute_funding_fee_rate(arg0: &FundingFeeModel, arg1: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::sdecimal::SDecimal, arg2: u64) : 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::srate::SRate {
        let v0 = 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::decimal::to_rate(0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::decimal::mul(arg0.multiplier, 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::sdecimal::value(&arg1)));
        if (0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::gt(&v0, &arg0.max)) {
            v0 = arg0.max;
        };
        0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::srate::from_rate(!0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::sdecimal::is_positive(&arg1), 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::div_by_u64(0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::mul_with_u64(v0, arg2), 28800))
    }

    public fun compute_rebase_fee_rate(arg0: &RebaseFeeModel, arg1: bool, arg2: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::Rate, arg3: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::Rate) : 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::Rate {
        if (arg1 && 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::le(&arg2, &arg3) || !arg1 && 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::ge(&arg2, &arg3)) {
            arg0.base
        } else {
            0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::add(arg0.base, 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::decimal::to_rate(0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::decimal::mul_with_rate(arg0.multiplier, 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::diff(arg2, arg3))))
        }
    }

    public fun compute_reserving_fee_rate(arg0: &ReservingFeeModel, arg1: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::Rate, arg2: u64) : 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::Rate {
        0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::div_by_u64(0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::mul_with_u64(0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::decimal::to_rate(0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::decimal::mul_with_rate(arg0.multiplier, arg1)), arg2), 28800)
    }

    public(friend) fun create_funding_fee_model(arg0: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::decimal::Decimal, arg1: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::Rate, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        let v1 = FundingFeeModel{
            id         : v0,
            multiplier : arg0,
            max        : arg1,
        };
        0x2::transfer::share_object<FundingFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun create_rebase_fee_model(arg0: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::Rate, arg1: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::decimal::Decimal, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        let v1 = RebaseFeeModel{
            id         : v0,
            base       : arg0,
            multiplier : arg1,
        };
        0x2::transfer::share_object<RebaseFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun create_reserving_fee_model(arg0: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::decimal::Decimal, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
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

