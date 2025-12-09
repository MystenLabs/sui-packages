module 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::lock_obligation {
    struct ObligationUnhealthyUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    public fun force_unlock_unhealthy<T0: drop>(arg0: &mut 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::Obligation, arg1: &mut 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::Market, arg2: &0x5f7929b94887cddc14ddfe7bfe9ae9e94d79ca3d06df174defe76e1646a715f6::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: T0) {
        0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::set_unlock<T0>(arg0, arg5);
        0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg4) / 1000);
        0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::accrue_interests_and_rewards(arg0, arg1);
        assert!(0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::fixed_point32_empower::gt(0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::debt_value::debts_value_usd(arg0, arg2, arg3, arg4), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4)), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::obligation_cant_forcely_unlocked());
        let v0 = ObligationUnhealthyUnlocked{
            obligation : 0x2::object::id<0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::obligation::Obligation>(arg0),
            witness    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObligationUnhealthyUnlocked>(v0);
    }

    // decompiled from Move bytecode v6
}

