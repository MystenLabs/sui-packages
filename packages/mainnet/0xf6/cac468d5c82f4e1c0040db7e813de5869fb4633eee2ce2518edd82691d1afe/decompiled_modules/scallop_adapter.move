module 0x9fc5e9f307399e60bef0a96242e5e8bad566c66740bf601bb10a00d1a0800fc5::scallop_adapter {
    public fun calculate_accounted_value_delta(arg0: u128, arg1: u128) : u64 {
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_math::accounted_value_delta(arg0, arg1)
    }

    public fun calculate_scoin_for_underlying<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg1: u128) : u64 {
        let (v0, v1) = get_exchange_rate<T0>(arg0);
        if (v0 == 0) {
            return (arg1 as u64)
        };
        ((((arg1 as u256) * (v1 as u256) + (v0 as u256) - 1) / (v0 as u256)) as u64)
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
        0x40746fcb81cdb8933f3c6101a0ed53f93e27a8d628c23dbaceb264a97c48e1c4::llv_math::select_receipt_token_withdraw_amount(arg0, arg1, arg2, arg3, arg4)
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

    // decompiled from Move bytecode v7
}

