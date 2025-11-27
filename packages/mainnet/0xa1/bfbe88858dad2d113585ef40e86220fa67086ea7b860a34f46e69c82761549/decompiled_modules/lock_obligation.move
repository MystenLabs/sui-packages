module 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::lock_obligation {
    struct ObligationUnhealthyUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    public fun force_unlock_unhealthy<T0: drop>(arg0: &mut 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::Obligation, arg1: &mut 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::Market, arg2: &0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: T0) {
        0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::set_unlock<T0>(arg0, arg5);
        0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg4) / 1000);
        0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::accrue_interests_and_rewards(arg0, arg1);
        assert!(0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::gt(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::debt_value::debts_value_usd(arg0, arg2, arg3, arg4), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4)), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::error::obligation_cant_forcely_unlocked());
        let v0 = ObligationUnhealthyUnlocked{
            obligation : 0x2::object::id<0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::Obligation>(arg0),
            witness    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObligationUnhealthyUnlocked>(v0);
    }

    // decompiled from Move bytecode v6
}

