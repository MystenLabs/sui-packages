module 0x5184b84a265204cb88bdc13da3f86069e2b16198b3a7218dfd95b0620d5c95c3::scallop_adapter {
    public fun calculate_accounted_value_delta(arg0: u128, arg1: u128) : u64 {
        if (arg1 <= arg0) {
            return 0
        };
        let v0 = arg1 - arg0;
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    public fun calculate_max_accounted_gap(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = ((((arg0 as u128) * (5 as u128) + 9999) / 10000) as u64);
        if (v0 == 0) {
            1
        } else {
            v0
        }
    }

    public fun calculate_scoin_for_underlying<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg1: u128) : u64 {
        let (v0, v1) = get_exchange_rate<T0>(arg0);
        if (v0 == 0) {
            return (arg1 as u64)
        };
        (((arg1 * v1 + v0 - 1) / v0) as u64)
    }

    public fun create_spool_account<T0>(arg0: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0> {
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::new_spool_account<T0>(arg0, arg1, arg2)
    }

    public fun deposit<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun get_available_liquidity<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : u64 {
        let (v0, _, _, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg0)), 0x1::type_name::with_defining_ids<T0>()));
        v0
    }

    public fun get_exchange_rate<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : (u128, u128) {
        let (v0, v1, v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg0)), 0x1::type_name::with_defining_ids<T0>()));
        let v4 = (v0 as u128) + (v1 as u128);
        let v5 = (v2 as u128);
        let v6 = if (v4 > v5) {
            v4 - v5
        } else {
            0
        };
        (v6, (v3 as u128))
    }

    public fun get_spool_staked_amount<T0>(arg0: &0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>) : u64 {
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<T0>(arg0)
    }

    public fun get_underlying_balance<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg1: u64) : u128 {
        let (v0, v1) = get_exchange_rate<T0>(arg0);
        if (v1 == 0) {
            return (arg1 as u128)
        };
        (arg1 as u128) * v0 / v1
    }

    public fun get_utilization_bps<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : u64 {
        let (v0, v1, _, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg0)), 0x1::type_name::with_defining_ids<T0>()));
        let v4 = (v0 as u128) + (v1 as u128);
        if (v4 == 0) {
            return 0
        };
        (((v1 as u128) * 10000 / v4) as u64)
    }

    public fun redeem_spool_rewards<T0, T1>(arg0: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T1>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun select_scoin_withdraw_amount(arg0: u128, arg1: u64, arg2: u128, arg3: u128, arg4: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            arg4 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = ((((arg0 as u256) * (arg3 as u256) + (arg2 as u256) - 1) / (arg2 as u256)) as u128);
        let v2 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_math::mul_div((arg4 as u128), arg3, arg2);
        let v3 = if (v1 < v2) {
            v1
        } else {
            v2
        };
        let v4 = if (v3 > (arg1 as u128)) {
            (arg1 as u128)
        } else {
            v3
        };
        (v4 as u64)
    }

    public fun stake_to_spool<T0>(arg0: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::stake<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun trigger_accrue(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x2::clock::Clock) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg0, arg1, arg2);
    }

    public fun unstake_from_spool<T0>(arg0: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun withdraw<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

