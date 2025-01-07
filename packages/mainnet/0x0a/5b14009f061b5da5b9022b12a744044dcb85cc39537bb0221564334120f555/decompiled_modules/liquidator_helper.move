module 0xa5b14009f061b5da5b9022b12a744044dcb85cc39537bb0221564334120f555::liquidator_helper {
    public fun force_unstake_if_unhealthy(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg2: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg3: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg5, arg4, arg8);
        if (!is_eligible_to_be_liquidated(arg4, arg5, arg6, arg7, arg8)) {
            return
        };
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::lock_key(arg4);
        if (0x1::option::is_none<0x1::type_name::TypeName>(&v0)) {
            return
        };
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::lock_key(arg4);
        if (*0x1::option::borrow<0x1::type_name::TypeName>(&v1) == 0x1::type_name::get<0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveProgramLockKey>()) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::force_unstake_unhealthy(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        };
    }

    public fun is_eligible_to_be_liquidated(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock) : bool {
        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4))
    }

    public fun repay_flash_loan<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T0>, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T0>(arg0, arg1, 0x2::coin::split<T0>(arg3, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T0>(&arg2) + 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T0>(&arg2), arg4), arg2, arg4);
    }

    // decompiled from Move bytecode v6
}

