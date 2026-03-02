module 0x39ef99065ebe8c97d2d266a44a3073609bda41245ae8691db3c36bddd7a65eca::query {
    struct MaxLiquidationAmount has copy, drop, store {
        max_repay_amount: u64,
        max_liq_amount: u64,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
    }

    public fun max_liquidation_amount<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x2::clock::Clock) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg5);
        let (v0, v1, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::calculate_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg5, 18446744073709551615);
        let v3 = MaxLiquidationAmount{
            max_repay_amount : v0,
            max_liq_amount   : v1,
            debt_type        : 0x1::type_name::get<T0>(),
            collateral_type  : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<MaxLiquidationAmount>(v3);
    }

    // decompiled from Move bytecode v6
}

