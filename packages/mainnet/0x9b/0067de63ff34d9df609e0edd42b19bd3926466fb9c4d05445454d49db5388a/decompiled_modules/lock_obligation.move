module 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::lock_obligation {
    struct ObligationUnhealthyUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    public fun force_unlock_unhealthy<T0: drop>(arg0: &mut 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::Obligation, arg1: &mut 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::Market, arg2: &0x177afe2b7c818730b4980df53cc683be7393d20cada006b02152d92210983a74::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: T0) {
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::set_unlock<T0>(arg0, arg5);
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg4) / 1000);
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::accrue_interests_and_rewards(arg0, arg1);
        assert!(0x47aee540b4cf13763b58341097db066dc43dfa0574cd74729b64694f097a4d5d::fixed_point32_empower::gt(0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::debt_value::debts_value_usd(arg0, arg2, arg3, arg4), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4)), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::obligation_cant_forcely_unlocked());
        let v0 = ObligationUnhealthyUnlocked{
            obligation : 0x2::object::id<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::Obligation>(arg0),
            witness    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObligationUnhealthyUnlocked>(v0);
    }

    // decompiled from Move bytecode v6
}

