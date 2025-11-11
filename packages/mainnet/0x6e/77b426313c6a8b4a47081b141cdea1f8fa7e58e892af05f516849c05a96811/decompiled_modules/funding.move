module 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding {
    struct FundingStateKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct FundingState has store, key {
        id: 0x2::object::UID,
        enabled: bool,
        last_update: u64,
        model: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::OiFundingModel,
    }

    struct SymbolsFundingResult has copy, drop {
        long_acc_funding_rate: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::srate::SRate,
        long_unrealised_funding_fee_value: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::SDecimal,
        short_acc_funding_rate: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::srate::SRate,
        short_unrealised_funding_fee_value: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::SDecimal,
        timestamp: u64,
    }

    public(friend) fun compute_oi_funding(arg0: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg1: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::srate::SRate, arg2: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::SDecimal, arg3: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, arg4: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::srate::SRate, arg5: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::SDecimal, arg6: &FundingState, arg7: u64) : SymbolsFundingResult {
        let v0 = arg7 - arg6.last_update;
        if (v0 == 0) {
            return SymbolsFundingResult{
                long_acc_funding_rate              : arg1,
                long_unrealised_funding_fee_value  : arg2,
                short_acc_funding_rate             : arg4,
                short_unrealised_funding_fee_value : arg5,
                timestamp                          : arg7,
            }
        };
        let v1 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::compute_oi_funding_rate(&arg6.model, arg0, arg3, v0);
        let v2 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::srate::negate(v1);
        SymbolsFundingResult{
            long_acc_funding_rate              : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::srate::add(arg1, v1),
            long_unrealised_funding_fee_value  : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::add(arg2, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::from_decimal(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::srate::is_positive(&v1), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::mul_with_rate(arg0, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::srate::value(&v1)))),
            short_acc_funding_rate             : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::srate::add(arg4, v2),
            short_unrealised_funding_fee_value : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::add(arg5, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::from_decimal(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::srate::is_positive(&v2), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::mul_with_rate(arg3, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::srate::value(&v2)))),
            timestamp                          : arg7,
        }
    }

    public(friend) fun create_funding_state<T0>(arg0: &0x2::clock::Clock, arg1: u256, arg2: u256, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : (FundingState, FundingStateKey<T0>) {
        let v0 = FundingState{
            id          : 0x2::object::new(arg4),
            enabled     : true,
            last_update : 0x2::clock::timestamp_ms(arg0) / 1000,
            model       : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::create_oi_funding_model(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg1), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg2), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::from_raw(arg3), arg4),
        };
        let v1 = FundingStateKey<T0>{dummy_field: false};
        (v0, v1)
    }

    public(friend) fun is_enabled(arg0: &FundingState) : bool {
        arg0.enabled
    }

    public(friend) fun new_funding_state_key<T0>() : FundingStateKey<T0> {
        FundingStateKey<T0>{dummy_field: false}
    }

    public(friend) fun refresh_symbol_oi_funding(arg0: SymbolsFundingResult, arg1: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol, arg2: bool) {
        let v0 = if (arg2) {
            arg0.long_acc_funding_rate
        } else {
            arg0.short_acc_funding_rate
        };
        let v1 = if (arg2) {
            arg0.long_unrealised_funding_fee_value
        } else {
            arg0.short_unrealised_funding_fee_value
        };
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::set_symbol_by_funding_state(arg1, v0, v1, arg0.timestamp);
    }

    public(friend) fun set_funding_state_enabled(arg0: &mut FundingState, arg1: bool) {
        arg0.enabled = arg1;
    }

    public(friend) fun set_funding_state_last_update(arg0: &mut FundingState, arg1: u64) {
        arg0.last_update = arg1;
    }

    public(friend) fun update_funding_model_params(arg0: &mut FundingState, arg1: u256, arg2: u256, arg3: u128) {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::update_oi_funding_model(&mut arg0.model, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

