module 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::lock_obligation {
    struct ObligationUnhealthyUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    public fun force_unlock_unhealthy<T0: drop>(arg0: &mut 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::Obligation, arg1: &mut 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::market::Market, arg2: &0x8ceeeb2bca5b5eb310b9436b0d7ce7d81b27ce0fb58370cbc200e2f9365730d1::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: T0) {
        0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::set_unlock<T0>(arg0, arg5);
        0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg4) / 1000);
        0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::accrue_interests_and_rewards(arg0, arg1);
        assert!(0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::fixed_point32_empower::gt(0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::debt_value::debts_value_usd(arg0, arg2, arg3, arg4), 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4)), 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::error::obligation_cant_forcely_unlocked());
        let v0 = ObligationUnhealthyUnlocked{
            obligation : 0x2::object::id<0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::obligation::Obligation>(arg0),
            witness    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObligationUnhealthyUnlocked>(v0);
    }

    // decompiled from Move bytecode v6
}

