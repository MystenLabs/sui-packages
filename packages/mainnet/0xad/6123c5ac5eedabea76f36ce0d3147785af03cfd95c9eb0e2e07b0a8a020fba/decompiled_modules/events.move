module 0xad6123c5ac5eedabea76f36ce0d3147785af03cfd95c9eb0e2e07b0a8a020fba::events {
    struct CreateVaultEvent has copy, drop {
        vault: address,
        sender: address,
    }

    struct CreateReceiptEvent has copy, drop {
        vault: address,
        sender: address,
        receipt_id: address,
    }

    struct DepositEvent has copy, drop {
        vault: address,
        sender: address,
        receipt_id: address,
        pool_address: address,
        amount: u64,
        shares: u64,
    }

    struct WithdrawEvent has copy, drop {
        vault: address,
        sender: address,
        receipt_id: address,
        pool_address: address,
        amount: u64,
        shares_burned: u64,
    }

    struct ClaimRewardEvent has copy, drop {
        vault: address,
        sender: address,
        receipt_id: address,
        reward_coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct CollectRewardEvent has copy, drop {
        vault: address,
        rule_index: u64,
        reward_coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct SyncMarketBalanceEvent has copy, drop {
        vault: address,
        pool_address: address,
        current_balance: u64,
    }

    struct ClaimManagementFeeEvent has copy, drop {
        vault: address,
        receipt_id: address,
        shares: u64,
    }

    struct ClaimPerformanceFeeEvent has copy, drop {
        vault: address,
        receipt_id: address,
        shares: u64,
    }

    struct AllocateEvent has copy, drop {
        vault: address,
        sender: address,
        pool_address: address,
        amount: u64,
    }

    struct DeallocateEvent has copy, drop {
        vault: address,
        sender: address,
        pool_address: address,
        amount: u64,
    }

    struct ProposalCreatedEvent has copy, drop {
        vault: address,
        proposal_type: u8,
        subject: address,
        executable_at: u64,
    }

    struct ProposalExecutedEvent has copy, drop {
        vault: address,
        proposal_type: u8,
        subject: address,
    }

    struct ProposalCancelledEvent has copy, drop {
        vault: address,
        proposal_type: u8,
        subject: address,
    }

    struct SetDefaultMarketEvent has copy, drop {
        vault: address,
        pool_address: address,
    }

    struct SetMarketStatusEvent has copy, drop {
        vault: address,
        pool_address: address,
        target_status: u8,
    }

    struct SetManagementFeeEvent has copy, drop {
        vault: address,
        old_fee: u64,
        new_fee: u64,
    }

    struct SetPerformanceFeeEvent has copy, drop {
        vault: address,
        old_fee: u64,
        new_fee: u64,
    }

    struct AddMarketEvent has copy, drop {
        vault: address,
        pool_address: address,
        cap: u64,
        penalty: u64,
        storage_address: address,
        asset_id: u8,
        incentive_v3_address: address,
        incentive_v2_address: address,
    }

    struct AllocatorAddedEvent has copy, drop {
        vault: address,
        cap_id: address,
        recipient: address,
    }

    struct AllocatorRemovedEvent has copy, drop {
        cap_id: address,
    }

    struct CuratorAddedEvent has copy, drop {
        vault: address,
        cap_id: address,
        recipient: address,
    }

    struct CuratorRemovedEvent has copy, drop {
        cap_id: address,
    }

    struct SetPausedEvent has copy, drop {
        vault: address,
        paused: bool,
    }

    struct SetLossEvent has copy, drop {
        vault: address,
        pool_address: address,
        loss: u64,
    }

    struct RewardRuleCreatedEvent has copy, drop {
        vault: address,
        navi_pool_id: address,
        reward_coin_type: 0x1::ascii::String,
        incentive_rule_id: address,
    }

    struct RewardRuleReactivatedEvent has copy, drop {
        vault: address,
        navi_pool_id: address,
        reward_coin_type: 0x1::ascii::String,
        incentive_rule_id: address,
    }

    struct RewardRuleDisabledEvent has copy, drop {
        vault: address,
        navi_pool_id: address,
        reward_coin_type: 0x1::ascii::String,
    }

    struct DepositRewardBalanceEvent has copy, drop {
        vault: address,
        reward_coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct SetRewardRateEvent has copy, drop {
        vault: address,
        reward_coin_type: 0x1::ascii::String,
        total_supply: u64,
        duration_ms: u64,
        rate: u256,
    }

    struct WithdrawRewardEvent has copy, drop {
        vault: address,
        reward_coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct SetVaultCapEvent has copy, drop {
        vault: address,
        vault_cap: u64,
    }

    struct SetMarketCapAndPenaltyEvent has copy, drop {
        vault: address,
        pool_address: address,
        cap: u64,
        penalty: u64,
    }

    public(friend) fun emit_add_market(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: address, arg5: u8, arg6: address, arg7: address) {
        let v0 = AddMarketEvent{
            vault                : arg0,
            pool_address         : arg1,
            cap                  : arg2,
            penalty              : arg3,
            storage_address      : arg4,
            asset_id             : arg5,
            incentive_v3_address : arg6,
            incentive_v2_address : arg7,
        };
        0x2::event::emit<AddMarketEvent>(v0);
    }

    public(friend) fun emit_allocate(arg0: address, arg1: address, arg2: address, arg3: u64) {
        let v0 = AllocateEvent{
            vault        : arg0,
            sender       : arg1,
            pool_address : arg2,
            amount       : arg3,
        };
        0x2::event::emit<AllocateEvent>(v0);
    }

    public(friend) fun emit_allocator_added(arg0: address, arg1: address, arg2: address) {
        let v0 = AllocatorAddedEvent{
            vault     : arg0,
            cap_id    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<AllocatorAddedEvent>(v0);
    }

    public(friend) fun emit_allocator_removed(arg0: address) {
        let v0 = AllocatorRemovedEvent{cap_id: arg0};
        0x2::event::emit<AllocatorRemovedEvent>(v0);
    }

    public(friend) fun emit_claim_management_fee(arg0: address, arg1: address, arg2: u64) {
        let v0 = ClaimManagementFeeEvent{
            vault      : arg0,
            receipt_id : arg1,
            shares     : arg2,
        };
        0x2::event::emit<ClaimManagementFeeEvent>(v0);
    }

    public(friend) fun emit_claim_performance_fee(arg0: address, arg1: address, arg2: u64) {
        let v0 = ClaimPerformanceFeeEvent{
            vault      : arg0,
            receipt_id : arg1,
            shares     : arg2,
        };
        0x2::event::emit<ClaimPerformanceFeeEvent>(v0);
    }

    public(friend) fun emit_claim_reward(arg0: address, arg1: address, arg2: address, arg3: 0x1::ascii::String, arg4: u64) {
        let v0 = ClaimRewardEvent{
            vault            : arg0,
            sender           : arg1,
            receipt_id       : arg2,
            reward_coin_type : arg3,
            amount           : arg4,
        };
        0x2::event::emit<ClaimRewardEvent>(v0);
    }

    public(friend) fun emit_collect_reward(arg0: address, arg1: u64, arg2: 0x1::ascii::String, arg3: u64) {
        let v0 = CollectRewardEvent{
            vault            : arg0,
            rule_index       : arg1,
            reward_coin_type : arg2,
            amount           : arg3,
        };
        0x2::event::emit<CollectRewardEvent>(v0);
    }

    public(friend) fun emit_create_receipt(arg0: address, arg1: address, arg2: address) {
        let v0 = CreateReceiptEvent{
            vault      : arg0,
            sender     : arg1,
            receipt_id : arg2,
        };
        0x2::event::emit<CreateReceiptEvent>(v0);
    }

    public(friend) fun emit_create_vault(arg0: address, arg1: address) {
        let v0 = CreateVaultEvent{
            vault  : arg0,
            sender : arg1,
        };
        0x2::event::emit<CreateVaultEvent>(v0);
    }

    public(friend) fun emit_curator_added(arg0: address, arg1: address, arg2: address) {
        let v0 = CuratorAddedEvent{
            vault     : arg0,
            cap_id    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<CuratorAddedEvent>(v0);
    }

    public(friend) fun emit_curator_removed(arg0: address) {
        let v0 = CuratorRemovedEvent{cap_id: arg0};
        0x2::event::emit<CuratorRemovedEvent>(v0);
    }

    public(friend) fun emit_deallocate(arg0: address, arg1: address, arg2: address, arg3: u64) {
        let v0 = DeallocateEvent{
            vault        : arg0,
            sender       : arg1,
            pool_address : arg2,
            amount       : arg3,
        };
        0x2::event::emit<DeallocateEvent>(v0);
    }

    public(friend) fun emit_deposit(arg0: address, arg1: address, arg2: address, arg3: address, arg4: u64, arg5: u64) {
        let v0 = DepositEvent{
            vault        : arg0,
            sender       : arg1,
            receipt_id   : arg2,
            pool_address : arg3,
            amount       : arg4,
            shares       : arg5,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public(friend) fun emit_deposit_reward_balance(arg0: address, arg1: 0x1::ascii::String, arg2: u64) {
        let v0 = DepositRewardBalanceEvent{
            vault            : arg0,
            reward_coin_type : arg1,
            amount           : arg2,
        };
        0x2::event::emit<DepositRewardBalanceEvent>(v0);
    }

    public(friend) fun emit_proposal_cancelled(arg0: address, arg1: u8, arg2: address) {
        let v0 = ProposalCancelledEvent{
            vault         : arg0,
            proposal_type : arg1,
            subject       : arg2,
        };
        0x2::event::emit<ProposalCancelledEvent>(v0);
    }

    public(friend) fun emit_proposal_created(arg0: address, arg1: u8, arg2: address, arg3: u64) {
        let v0 = ProposalCreatedEvent{
            vault         : arg0,
            proposal_type : arg1,
            subject       : arg2,
            executable_at : arg3,
        };
        0x2::event::emit<ProposalCreatedEvent>(v0);
    }

    public(friend) fun emit_proposal_executed(arg0: address, arg1: u8, arg2: address) {
        let v0 = ProposalExecutedEvent{
            vault         : arg0,
            proposal_type : arg1,
            subject       : arg2,
        };
        0x2::event::emit<ProposalExecutedEvent>(v0);
    }

    public(friend) fun emit_reward_rule_created(arg0: address, arg1: address, arg2: 0x1::ascii::String, arg3: address) {
        let v0 = RewardRuleCreatedEvent{
            vault             : arg0,
            navi_pool_id      : arg1,
            reward_coin_type  : arg2,
            incentive_rule_id : arg3,
        };
        0x2::event::emit<RewardRuleCreatedEvent>(v0);
    }

    public(friend) fun emit_reward_rule_disabled(arg0: address, arg1: address, arg2: 0x1::ascii::String) {
        let v0 = RewardRuleDisabledEvent{
            vault            : arg0,
            navi_pool_id     : arg1,
            reward_coin_type : arg2,
        };
        0x2::event::emit<RewardRuleDisabledEvent>(v0);
    }

    public(friend) fun emit_reward_rule_reactivated(arg0: address, arg1: address, arg2: 0x1::ascii::String, arg3: address) {
        let v0 = RewardRuleReactivatedEvent{
            vault             : arg0,
            navi_pool_id      : arg1,
            reward_coin_type  : arg2,
            incentive_rule_id : arg3,
        };
        0x2::event::emit<RewardRuleReactivatedEvent>(v0);
    }

    public(friend) fun emit_set_default_market(arg0: address, arg1: address) {
        let v0 = SetDefaultMarketEvent{
            vault        : arg0,
            pool_address : arg1,
        };
        0x2::event::emit<SetDefaultMarketEvent>(v0);
    }

    public(friend) fun emit_set_loss(arg0: address, arg1: address, arg2: u64) {
        let v0 = SetLossEvent{
            vault        : arg0,
            pool_address : arg1,
            loss         : arg2,
        };
        0x2::event::emit<SetLossEvent>(v0);
    }

    public(friend) fun emit_set_management_fee(arg0: address, arg1: u64, arg2: u64) {
        let v0 = SetManagementFeeEvent{
            vault   : arg0,
            old_fee : arg1,
            new_fee : arg2,
        };
        0x2::event::emit<SetManagementFeeEvent>(v0);
    }

    public(friend) fun emit_set_market_cap_and_penalty(arg0: address, arg1: address, arg2: u64, arg3: u64) {
        let v0 = SetMarketCapAndPenaltyEvent{
            vault        : arg0,
            pool_address : arg1,
            cap          : arg2,
            penalty      : arg3,
        };
        0x2::event::emit<SetMarketCapAndPenaltyEvent>(v0);
    }

    public(friend) fun emit_set_market_status(arg0: address, arg1: address, arg2: u8) {
        let v0 = SetMarketStatusEvent{
            vault         : arg0,
            pool_address  : arg1,
            target_status : arg2,
        };
        0x2::event::emit<SetMarketStatusEvent>(v0);
    }

    public(friend) fun emit_set_paused(arg0: address, arg1: bool) {
        let v0 = SetPausedEvent{
            vault  : arg0,
            paused : arg1,
        };
        0x2::event::emit<SetPausedEvent>(v0);
    }

    public(friend) fun emit_set_performance_fee(arg0: address, arg1: u64, arg2: u64) {
        let v0 = SetPerformanceFeeEvent{
            vault   : arg0,
            old_fee : arg1,
            new_fee : arg2,
        };
        0x2::event::emit<SetPerformanceFeeEvent>(v0);
    }

    public(friend) fun emit_set_reward_rate(arg0: address, arg1: 0x1::ascii::String, arg2: u64, arg3: u64, arg4: u256) {
        let v0 = SetRewardRateEvent{
            vault            : arg0,
            reward_coin_type : arg1,
            total_supply     : arg2,
            duration_ms      : arg3,
            rate             : arg4,
        };
        0x2::event::emit<SetRewardRateEvent>(v0);
    }

    public(friend) fun emit_set_vault_cap(arg0: address, arg1: u64) {
        let v0 = SetVaultCapEvent{
            vault     : arg0,
            vault_cap : arg1,
        };
        0x2::event::emit<SetVaultCapEvent>(v0);
    }

    public(friend) fun emit_sync_market_balance(arg0: address, arg1: address, arg2: u64) {
        let v0 = SyncMarketBalanceEvent{
            vault           : arg0,
            pool_address    : arg1,
            current_balance : arg2,
        };
        0x2::event::emit<SyncMarketBalanceEvent>(v0);
    }

    public(friend) fun emit_withdraw(arg0: address, arg1: address, arg2: address, arg3: address, arg4: u64, arg5: u64) {
        let v0 = WithdrawEvent{
            vault         : arg0,
            sender        : arg1,
            receipt_id    : arg2,
            pool_address  : arg3,
            amount        : arg4,
            shares_burned : arg5,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    public(friend) fun emit_withdraw_reward(arg0: address, arg1: 0x1::ascii::String, arg2: u64) {
        let v0 = WithdrawRewardEvent{
            vault            : arg0,
            reward_coin_type : arg1,
            amount           : arg2,
        };
        0x2::event::emit<WithdrawRewardEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

