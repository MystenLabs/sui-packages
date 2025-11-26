module 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::lock_obligation {
    struct ObligationUnhealthyUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    public fun force_unlock_unhealthy<T0: drop>(arg0: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation, arg1: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::Market, arg2: &0xf02732656b4dc135a20a52ff5495425541d4280c54aa93ef5f8bceecf49b9f9::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: T0) {
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::set_unlock<T0>(arg0, arg5);
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg4) / 1000);
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::accrue_interests_and_rewards(arg0, arg1);
        assert!(0x724ff007e3cb5e2464e94283edecd0c610567d475a980beaa8f404d9c15d3ba7::fixed_point32_empower::gt(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::debt_value::debts_value_usd(arg0, arg2, arg3, arg4), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4)), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::obligation_cant_forcely_unlocked());
        let v0 = ObligationUnhealthyUnlocked{
            obligation : 0x2::object::id<0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation>(arg0),
            witness    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObligationUnhealthyUnlocked>(v0);
    }

    // decompiled from Move bytecode v6
}

