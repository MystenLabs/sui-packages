module 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::lock_obligation {
    struct ObligationUnhealthyUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    public fun force_unlock_unhealthy<T0: drop>(arg0: &mut 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::Obligation, arg1: &mut 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::market::Market, arg2: &0x46f8c31ef54ad3678fae562c896eeb303dd4fd58509f2393c9e3bdc7b8987925::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: T0) {
        0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::set_unlock<T0>(arg0, arg5);
        0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg4) / 1000);
        0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::accrue_interests_and_rewards(arg0, arg1);
        assert!(0xf8dff55846654f62d2e2f2e08a28367bb80c6f91902ed58aacc100ba54279c3c::fixed_point32_empower::gt(0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::debt_value::debts_value_usd(arg0, arg2, arg3, arg4), 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4)), 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::error::obligation_cant_forcely_unlocked());
        let v0 = ObligationUnhealthyUnlocked{
            obligation : 0x2::object::id<0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::Obligation>(arg0),
            witness    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObligationUnhealthyUnlocked>(v0);
    }

    // decompiled from Move bytecode v6
}

