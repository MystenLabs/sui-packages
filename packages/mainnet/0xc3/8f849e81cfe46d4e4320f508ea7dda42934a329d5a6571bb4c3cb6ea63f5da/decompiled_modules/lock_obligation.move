module 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::lock_obligation {
    struct ObligationUnhealthyUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    public fun force_unlock_unhealthy<T0: drop>(arg0: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: T0) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg4) / 1000);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::accrue_interests_and_rewards(arg0, arg1);
        assert!(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4)), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::obligation_cant_forcely_unlocked());
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::set_unlock<T0>(arg0, arg5);
        let v0 = ObligationUnhealthyUnlocked{
            obligation : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg0),
            witness    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObligationUnhealthyUnlocked>(v0);
    }

    // decompiled from Move bytecode v6
}

