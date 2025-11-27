module 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::lock_obligation {
    struct ObligationUnhealthyUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    public fun force_unlock_unhealthy<T0: drop>(arg0: &mut 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::Obligation, arg1: &mut 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::Market, arg2: &0xed4cd0afbc14d8961499a2523961e371d72b6a12abdd4a0da2d39cd1ca441472::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: T0) {
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::set_unlock<T0>(arg0, arg5);
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg4) / 1000);
        0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::accrue_interests_and_rewards(arg0, arg1);
        assert!(0x8a0d9d6a55c999c37f153a7e282ca4438d00e411bd5b92ef0fad87391c78c08d::fixed_point32_empower::gt(0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::debt_value::debts_value_usd(arg0, arg2, arg3, arg4), 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4)), 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::error::obligation_cant_forcely_unlocked());
        let v0 = ObligationUnhealthyUnlocked{
            obligation : 0x2::object::id<0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::Obligation>(arg0),
            witness    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObligationUnhealthyUnlocked>(v0);
    }

    // decompiled from Move bytecode v6
}

