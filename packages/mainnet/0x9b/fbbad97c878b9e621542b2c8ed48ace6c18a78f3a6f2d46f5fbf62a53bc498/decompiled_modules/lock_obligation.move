module 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::lock_obligation {
    struct ObligationUnhealthyUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    public fun force_unlock_unhealthy<T0: drop>(arg0: &mut 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::Obligation, arg1: &mut 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::Market, arg2: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: T0) {
        0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg4) / 1000);
        0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::accrue_interests_and_rewards(arg0, arg1);
        assert!(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::fixed_point32_empower::gt(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4)), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::error::obligation_cant_forcely_unlocked());
        0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::set_unlock<T0>(arg0, arg5);
        let v0 = ObligationUnhealthyUnlocked{
            obligation : 0x2::object::id<0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::obligation::Obligation>(arg0),
            witness    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObligationUnhealthyUnlocked>(v0);
    }

    // decompiled from Move bytecode v6
}

