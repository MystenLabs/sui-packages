module 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::lock_obligation {
    struct ObligationUnhealthyUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    public fun force_unlock_unhealthy<T0: drop>(arg0: &mut 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::Obligation, arg1: &mut 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market::Market, arg2: &0xca1af76adf00b3fd346ac132e219342e535ef7fdce5a4df8793b51f03e93cd9d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: T0) {
        0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::set_unlock<T0>(arg0, arg5);
        0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg4) / 1000);
        0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::accrue_interests_and_rewards(arg0, arg1);
        assert!(0x16e04cbe605ede8d3821e07f4ab7b95a61a81e15b5334dcb11bad25ac9822041::fixed_point32_empower::gt(0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::debt_value::debts_value_usd(arg0, arg2, arg3, arg4), 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4)), 0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::error::obligation_cant_forcely_unlocked());
        let v0 = ObligationUnhealthyUnlocked{
            obligation : 0x2::object::id<0x69c1ea2f0a5af234fab8e96a5a17a73008f0a6674fe98fb1381a79e92f34d470::obligation::Obligation>(arg0),
            witness    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObligationUnhealthyUnlocked>(v0);
    }

    // decompiled from Move bytecode v6
}

