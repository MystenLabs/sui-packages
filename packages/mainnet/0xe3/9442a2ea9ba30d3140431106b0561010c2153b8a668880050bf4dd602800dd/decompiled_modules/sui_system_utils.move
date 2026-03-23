module 0xe39442a2ea9ba30d3140431106b0561010c2153b8a668880050bf4dd602800dd::sui_system_utils {
    public fun calculate_rewards(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x3::staking_pool::StakedSui, arg2: &0x2::tx_context::TxContext) : u64 {
        abort 0
    }

    public fun calculate_rewards_at_epoch(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x3::staking_pool::StakedSui, arg2: u64) : u64 {
        abort 0
    }

    public fun is_validator_active(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &address) : bool {
        abort 0
    }

    public fun pool_token_exchange_rate_at_epoch(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x3::staking_pool::StakedSui, arg2: u64) : 0x3::staking_pool::PoolTokenExchangeRate {
        abort 0
    }

    public fun request_withdraw_stake_vec_non_entry(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: vector<0x3::staking_pool::StakedSui>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        abort 0
    }

    public fun staked_sui_principal_and_rewards(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x3::staking_pool::StakedSui, arg2: &0x2::tx_context::TxContext) : (u64, u64) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

