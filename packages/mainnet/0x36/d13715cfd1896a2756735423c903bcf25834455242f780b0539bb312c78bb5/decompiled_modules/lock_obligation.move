module 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::lock_obligation {
    struct ObligationUnhealthyUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    public fun force_unlock_unhealthy<T0: drop>(arg0: &mut 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::Obligation, arg1: &mut 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::Market, arg2: &0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: T0) {
        0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::set_unlock<T0>(arg0, arg5);
        0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg4) / 1000);
        0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::accrue_interests_and_rewards(arg0, arg1);
        assert!(0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::gt(0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::debt_value::debts_value_usd(arg0, arg2, arg3, arg4), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4)), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::error::obligation_cant_forcely_unlocked());
        let v0 = ObligationUnhealthyUnlocked{
            obligation : 0x2::object::id<0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::Obligation>(arg0),
            witness    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObligationUnhealthyUnlocked>(v0);
    }

    // decompiled from Move bytecode v6
}

