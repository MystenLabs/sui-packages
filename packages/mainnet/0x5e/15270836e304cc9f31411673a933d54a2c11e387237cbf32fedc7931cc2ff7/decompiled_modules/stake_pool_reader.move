module 0x5e15270836e304cc9f31411673a933d54a2c11e387237cbf32fedc7931cc2ff7::stake_pool_reader {
    struct PoolInfo has copy, drop, store {
        sui_balance: u64,
        total_stake: u64,
        exchange_rate_sui: u64,
        exchange_rate_token: u64,
    }

    struct HistoricalExchangeRate has copy, drop, store {
        epoch: u64,
        sui_amount: u64,
        pool_token_amount: u64,
    }

    public fun get_historical_exchange_rate(arg0: &0x3::staking_pool::StakingPool, arg1: u64) : HistoricalExchangeRate {
        let v0 = 0x3::staking_pool::pool_token_exchange_rate_at_epoch(arg0, arg1);
        HistoricalExchangeRate{
            epoch             : arg1,
            sui_amount        : 0x3::staking_pool::sui_amount(&v0),
            pool_token_amount : 0x3::staking_pool::pool_token_amount(&v0),
        }
    }

    public fun read_pool_info(arg0: &0x3::staking_pool::StakingPool, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x3::staking_pool::pool_token_exchange_rate_at_epoch(arg0, 0x2::tx_context::epoch(arg1));
        let v1 = PoolInfo{
            sui_balance         : 0x3::staking_pool::sui_balance(arg0),
            total_stake         : 0x3::staking_pool::pending_stake_amount(arg0),
            exchange_rate_sui   : 0x3::staking_pool::sui_amount(&v0),
            exchange_rate_token : 0x3::staking_pool::pool_token_amount(&v0),
        };
        0x1::debug::print<PoolInfo>(&v1);
    }

    // decompiled from Move bytecode v6
}

