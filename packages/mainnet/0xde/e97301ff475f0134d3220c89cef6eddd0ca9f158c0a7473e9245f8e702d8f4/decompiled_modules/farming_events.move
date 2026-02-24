module 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_events {
    struct FarmingPoolCreateEvent has copy, drop {
        pool_id: address,
        caller: address,
        stake_token_type: 0x1::type_name::TypeName,
        model: u8,
        market_id: u64,
        hearn_addr: address,
        vault_addr: address,
        timestamp_ms: u64,
    }

    struct FarmingRewardConfigAddEvent has copy, drop {
        pool_id: address,
        caller: address,
        reward_bank_id: address,
        reward_token_type: 0x1::type_name::TypeName,
        start_time: u64,
        reward_per_second: u64,
        end_time: u64,
        timestamp_ms: u64,
    }

    struct FarmingRewardBankFundEvent has copy, drop {
        pool_id: address,
        caller: address,
        reward_bank_id: address,
        reward_token_type: 0x1::type_name::TypeName,
        amount: u64,
        timestamp_ms: u64,
    }

    struct FarmingRewardBankExtractEvent has copy, drop {
        pool_id: address,
        caller: address,
        reward_bank_id: address,
        reward_token_type: 0x1::type_name::TypeName,
        amount: u64,
        timestamp_ms: u64,
    }

    struct FarmingRewardConfigUpdateEvent has copy, drop {
        pool_id: address,
        caller: address,
        reward_bank_id: address,
        reward_token_type: 0x1::type_name::TypeName,
        start_time: u64,
        reward_per_second: u64,
        end_time: u64,
        timestamp_ms: u64,
    }

    struct FarmingPoolPauseEvent has copy, drop {
        pool_id: address,
        caller: address,
        timestamp_ms: u64,
    }

    struct FarmingPoolResumeEvent has copy, drop {
        pool_id: address,
        caller: address,
        timestamp_ms: u64,
    }

    struct FarmingStakeEvent has copy, drop {
        pool_id: address,
        user: address,
        amount: u128,
        total_shares: u128,
        timestamp_ms: u64,
    }

    struct FarmingUnstakeEvent has copy, drop {
        pool_id: address,
        user: address,
        amount: u128,
        total_shares: u128,
        timestamp_ms: u64,
    }

    struct FarmingClaimEvent has copy, drop {
        pool_id: address,
        reward_token_type: 0x1::type_name::TypeName,
        user: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct FarmingRoleUpdateEvent has copy, drop {
        caller: address,
        role: u8,
        account: address,
        added: bool,
        timestamp_ms: u64,
    }

    struct FarmingMigrateEvent has copy, drop {
        caller: address,
        new_version: u64,
        timestamp_ms: u64,
    }

    public(friend) fun emit_claim(arg0: address, arg1: 0x1::type_name::TypeName, arg2: address, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let (_, v1) = timestamp(arg4);
        let v2 = FarmingClaimEvent{
            pool_id           : arg0,
            reward_token_type : arg1,
            user              : arg2,
            amount            : arg3,
            timestamp_ms      : v1,
        };
        0x2::event::emit<FarmingClaimEvent>(v2);
    }

    public(friend) fun emit_migrate(arg0: u64, arg1: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg1);
        let v2 = FarmingMigrateEvent{
            caller       : v0,
            new_version  : arg0,
            timestamp_ms : v1,
        };
        0x2::event::emit<FarmingMigrateEvent>(v2);
    }

    public(friend) fun emit_pool_create(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u8, arg3: u64, arg4: address, arg5: address, arg6: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg6);
        let v2 = FarmingPoolCreateEvent{
            pool_id          : arg0,
            caller           : v0,
            stake_token_type : arg1,
            model            : arg2,
            market_id        : arg3,
            hearn_addr       : arg4,
            vault_addr       : arg5,
            timestamp_ms     : v1,
        };
        0x2::event::emit<FarmingPoolCreateEvent>(v2);
    }

    public(friend) fun emit_pool_pause(arg0: address, arg1: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg1);
        let v2 = FarmingPoolPauseEvent{
            pool_id      : arg0,
            caller       : v0,
            timestamp_ms : v1,
        };
        0x2::event::emit<FarmingPoolPauseEvent>(v2);
    }

    public(friend) fun emit_pool_resume(arg0: address, arg1: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg1);
        let v2 = FarmingPoolResumeEvent{
            pool_id      : arg0,
            caller       : v0,
            timestamp_ms : v1,
        };
        0x2::event::emit<FarmingPoolResumeEvent>(v2);
    }

    public(friend) fun emit_reward_bank_extract(arg0: address, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg4);
        let v2 = FarmingRewardBankExtractEvent{
            pool_id           : arg0,
            caller            : v0,
            reward_bank_id    : arg1,
            reward_token_type : arg2,
            amount            : arg3,
            timestamp_ms      : v1,
        };
        0x2::event::emit<FarmingRewardBankExtractEvent>(v2);
    }

    public(friend) fun emit_reward_bank_fund(arg0: address, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg4);
        let v2 = FarmingRewardBankFundEvent{
            pool_id           : arg0,
            caller            : v0,
            reward_bank_id    : arg1,
            reward_token_type : arg2,
            amount            : arg3,
            timestamp_ms      : v1,
        };
        0x2::event::emit<FarmingRewardBankFundEvent>(v2);
    }

    public(friend) fun emit_reward_config_add(arg0: address, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg6);
        let v2 = FarmingRewardConfigAddEvent{
            pool_id           : arg0,
            caller            : v0,
            reward_bank_id    : arg1,
            reward_token_type : arg2,
            start_time        : arg3,
            reward_per_second : arg4,
            end_time          : arg5,
            timestamp_ms      : v1,
        };
        0x2::event::emit<FarmingRewardConfigAddEvent>(v2);
    }

    public(friend) fun emit_reward_config_update(arg0: address, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg6);
        let v2 = FarmingRewardConfigUpdateEvent{
            pool_id           : arg0,
            caller            : v0,
            reward_bank_id    : arg1,
            reward_token_type : arg2,
            start_time        : arg3,
            reward_per_second : arg4,
            end_time          : arg5,
            timestamp_ms      : v1,
        };
        0x2::event::emit<FarmingRewardConfigUpdateEvent>(v2);
    }

    public(friend) fun emit_role_update(arg0: u8, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1) = timestamp(arg3);
        let v2 = FarmingRoleUpdateEvent{
            caller       : v0,
            role         : arg0,
            account      : arg1,
            added        : arg2,
            timestamp_ms : v1,
        };
        0x2::event::emit<FarmingRoleUpdateEvent>(v2);
    }

    public(friend) fun emit_stake(arg0: address, arg1: address, arg2: u128, arg3: u128, arg4: &0x2::tx_context::TxContext) {
        let (_, v1) = timestamp(arg4);
        let v2 = FarmingStakeEvent{
            pool_id      : arg0,
            user         : arg1,
            amount       : arg2,
            total_shares : arg3,
            timestamp_ms : v1,
        };
        0x2::event::emit<FarmingStakeEvent>(v2);
    }

    public(friend) fun emit_unstake(arg0: address, arg1: address, arg2: u128, arg3: u128, arg4: &0x2::tx_context::TxContext) {
        let (_, v1) = timestamp(arg4);
        let v2 = FarmingUnstakeEvent{
            pool_id      : arg0,
            user         : arg1,
            amount       : arg2,
            total_shares : arg3,
            timestamp_ms : v1,
        };
        0x2::event::emit<FarmingUnstakeEvent>(v2);
    }

    fun timestamp(arg0: &0x2::tx_context::TxContext) : (address, u64) {
        (0x2::tx_context::sender(arg0), 0x2::tx_context::epoch_timestamp_ms(arg0))
    }

    // decompiled from Move bytecode v6
}

