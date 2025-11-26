module 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::lock_obligation {
    struct ObligationUnhealthyUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    public fun force_unlock_unhealthy<T0: drop>(arg0: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::Obligation, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg2: &0xe6ddf4097f892306408ddbc8da0e84a86cc64f6fd09c3b4130a5591a32b2aec8::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: T0) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::set_unlock<T0>(arg0, arg5);
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg4) / 1000);
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::accrue_interests_and_rewards(arg0, arg1);
        assert!(0x7eaac45a28873a47c2de190f87f59e40e140017c6c4cc5e82b3a1baaaf7d20e::fixed_point32_empower::gt(0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::debt_value::debts_value_usd(arg0, arg2, arg3, arg4), 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4)), 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::obligation_cant_forcely_unlocked());
        let v0 = ObligationUnhealthyUnlocked{
            obligation : 0x2::object::id<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::Obligation>(arg0),
            witness    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObligationUnhealthyUnlocked>(v0);
    }

    // decompiled from Move bytecode v6
}

