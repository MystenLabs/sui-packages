module 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model {
    struct RebaseFeeModel has key {
        id: 0x2::object::UID,
        base: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate,
        multiplier: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
    }

    struct ReservingFeeModel has key {
        id: 0x2::object::UID,
        multiplier: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
    }

    struct FundingFeeModel has key {
        id: 0x2::object::UID,
        multiplier: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        max: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate,
    }

    public fun compute_funding_fee_rate(arg0: &FundingFeeModel, arg1: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::SDecimal, arg2: u64) : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::srate::SRate {
        let v0 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::to_rate(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::mul(arg0.multiplier, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::value(&arg1)));
        if (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::gt(&v0, &arg0.max)) {
            v0 = arg0.max;
        };
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::srate::from_rate(!0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::is_positive(&arg1), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::div_by_u64(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::mul_with_u64(v0, arg2), 28800))
    }

    public fun compute_rebase_fee_rate(arg0: &RebaseFeeModel, arg1: bool, arg2: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg3: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate) : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate {
        if (arg1 && 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::le(&arg2, &arg3) || !arg1 && 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::ge(&arg2, &arg3)) {
            arg0.base
        } else {
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::add(arg0.base, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::to_rate(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::mul_with_rate(arg0.multiplier, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::diff(arg2, arg3))))
        }
    }

    public fun compute_reserving_fee_rate(arg0: &ReservingFeeModel, arg1: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg2: u64) : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::div_by_u64(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::mul_with_u64(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::to_rate(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::mul_with_rate(arg0.multiplier, arg1)), arg2), 28800)
    }

    public(friend) fun create_funding_fee_model(arg0: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg1: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        validate_multiplier(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::to_raw(arg0));
        let v0 = 0x2::object::new(arg2);
        let v1 = FundingFeeModel{
            id         : v0,
            multiplier : arg0,
            max        : arg1,
        };
        0x2::transfer::share_object<FundingFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun create_rebase_fee_model(arg0: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg1: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        validate_base((0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::to_raw(arg0) as u256));
        validate_multiplier(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::to_raw(arg1));
        let v0 = 0x2::object::new(arg2);
        let v1 = RebaseFeeModel{
            id         : v0,
            base       : arg0,
            multiplier : arg1,
        };
        0x2::transfer::share_object<RebaseFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun create_reserving_fee_model(arg0: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        validate_multiplier(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::to_raw(arg0));
        let v0 = 0x2::object::new(arg1);
        let v1 = ReservingFeeModel{
            id         : v0,
            multiplier : arg0,
        };
        0x2::transfer::share_object<ReservingFeeModel>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    entry fun update_funding_fee_model(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut FundingFeeModel, arg2: u256, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) {
        validate_multiplier(arg2);
        validate_max_rate((arg3 as u256));
        arg1.multiplier = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg2);
        arg1.max = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::from_raw(arg3);
    }

    entry fun update_rebase_fee_model(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut RebaseFeeModel, arg2: u128, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        validate_base((arg2 as u256));
        validate_multiplier(arg3);
        arg1.base = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::from_raw(arg2);
        arg1.multiplier = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg3);
    }

    entry fun update_reserving_fee_model(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut ReservingFeeModel, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        validate_multiplier(arg2);
        arg1.multiplier = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg2);
    }

    fun validate_base(arg0: u256) {
        assert!(arg0 >= 100000000000000 && arg0 <= 100000000000000000, 19001);
    }

    fun validate_max_rate(arg0: u256) {
        assert!(arg0 >= 100000000000000 && arg0 <= 10000000000000000, 19003);
    }

    fun validate_multiplier(arg0: u256) {
        assert!(arg0 >= 100000000000000 && arg0 <= 100000000000000000, 19002);
    }

    // decompiled from Move bytecode v6
}

