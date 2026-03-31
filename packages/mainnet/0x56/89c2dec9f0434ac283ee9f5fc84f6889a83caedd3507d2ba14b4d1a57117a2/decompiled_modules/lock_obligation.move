module 0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::lock_obligation {
    struct ObligationUnhealthyUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    public fun force_unlock_unhealthy<T0: drop>(arg0: &mut 0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::obligation::Obligation, arg1: &mut 0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::market::Market, arg2: &0xa6e55b3e7942faf5e3399233f3b0aa03042e01bf1f278e58c130ca824274942f::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: T0) {
        0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::obligation::set_unlock<T0>(arg0, arg5);
        0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg4) / 1000);
        0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::obligation::accrue_interests_and_rewards(arg0, arg1);
        assert!(0xda89b111cc86b01f38acf4b68987e400a7019c743f82b2490fe1cb66dac5205a::fixed_point32_empower::gt(0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::debt_value::debts_value_usd(arg0, arg2, arg3, arg4), 0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4)), 0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::error::obligation_cant_forcely_unlocked());
        let v0 = ObligationUnhealthyUnlocked{
            obligation : 0x2::object::id<0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::obligation::Obligation>(arg0),
            witness    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObligationUnhealthyUnlocked>(v0);
    }

    // decompiled from Move bytecode v6
}

