module 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::lock_obligation {
    struct ObligationUnhealthyUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    public fun force_unlock_unhealthy<T0: drop>(arg0: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::Obligation, arg1: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::Market, arg2: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: T0) {
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg4) / 1000);
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::accrue_interests_and_rewards(arg0, arg1);
        assert!(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::fixed_point32_empower::gt(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4)), 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::error::obligation_cant_forcely_unlocked());
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::set_unlock<T0>(arg0, arg5);
        let v0 = ObligationUnhealthyUnlocked{
            obligation : 0x2::object::id<0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::Obligation>(arg0),
            witness    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObligationUnhealthyUnlocked>(v0);
    }

    // decompiled from Move bytecode v6
}

