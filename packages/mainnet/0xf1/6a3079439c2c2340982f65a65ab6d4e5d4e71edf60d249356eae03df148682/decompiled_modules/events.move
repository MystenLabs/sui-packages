module 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::events {
    struct CreatedVaultEvent has copy, drop {
        vault_id: 0x2::object::ID,
        vault_bank_account: address,
        perpetual_id: 0x2::object::ID,
        operator: address,
    }

    struct VaultOperatorUpdateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        operator: address,
    }

    struct VaultPauseUpdateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_paused: bool,
        withdraw_paused: bool,
        claim_paused: bool,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        sender: address,
        receiver: address,
        amount_deposited: u64,
        user_new_shares: u64,
        user_total_shares: u64,
        vault_total_shares: u64,
        vault_total_amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        receiver: address,
        amount_withdrawn: u64,
        shares_used: u64,
        user_remaining_shares: u64,
        vault_total_shares: u64,
        vault_total_amount: u64,
    }

    struct CreatedRewardsPoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        controller: address,
    }

    struct RewardsAmountDepositedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        depositor: address,
        amount_deposited: u64,
        pool_balance: u64,
    }

    struct RewardsClaimedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        caller: address,
        receiver: address,
        amount: u64,
        nonce: u128,
    }

    struct FundsClaimedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        caller: address,
        receiver: address,
        amount: u64,
    }

    struct RewardPoolControllerUpdateEvent has copy, drop {
        pool_id: 0x2::object::ID,
        controller: address,
    }

    public(friend) fun emit_created_rewards_pool_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = CreatedRewardsPoolEvent{
            pool_id    : arg0,
            controller : arg1,
        };
        0x2::event::emit<CreatedRewardsPoolEvent>(v0);
    }

    public(friend) fun emit_created_vault_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: address) {
        let v0 = CreatedVaultEvent{
            vault_id           : arg0,
            vault_bank_account : arg1,
            perpetual_id       : arg2,
            operator           : arg3,
        };
        0x2::event::emit<CreatedVaultEvent>(v0);
    }

    public(friend) fun emit_funds_claimed_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64) {
        let v0 = FundsClaimedEvent{
            vault_id : arg0,
            caller   : arg1,
            receiver : arg2,
            amount   : arg3,
        };
        0x2::event::emit<FundsClaimedEvent>(v0);
    }

    public(friend) fun emit_funds_deposited_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = DepositEvent{
            vault_id           : arg0,
            sender             : arg1,
            receiver           : arg2,
            amount_deposited   : arg3,
            user_new_shares    : arg4,
            user_total_shares  : arg5,
            vault_total_shares : arg6,
            vault_total_amount : arg7,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public(friend) fun emit_funds_withdrawn_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = WithdrawEvent{
            vault_id              : arg0,
            receiver              : arg1,
            amount_withdrawn      : arg2,
            shares_used           : arg3,
            user_remaining_shares : arg4,
            vault_total_shares    : arg5,
            vault_total_amount    : arg6,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    public(friend) fun emit_reward_amount_deposited_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = RewardsAmountDepositedEvent{
            pool_id          : arg0,
            depositor        : arg1,
            amount_deposited : arg2,
            pool_balance     : arg3,
        };
        0x2::event::emit<RewardsAmountDepositedEvent>(v0);
    }

    public(friend) fun emit_rewards_claimed_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u128) {
        let v0 = RewardsClaimedEvent{
            pool_id  : arg0,
            caller   : arg1,
            receiver : arg2,
            amount   : arg3,
            nonce    : arg4,
        };
        0x2::event::emit<RewardsClaimedEvent>(v0);
    }

    public(friend) fun emit_rewards_pool_controller_update_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = RewardPoolControllerUpdateEvent{
            pool_id    : arg0,
            controller : arg1,
        };
        0x2::event::emit<RewardPoolControllerUpdateEvent>(v0);
    }

    public(friend) fun emit_vault_operator_update_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = VaultOperatorUpdateEvent{
            vault_id : arg0,
            operator : arg1,
        };
        0x2::event::emit<VaultOperatorUpdateEvent>(v0);
    }

    public(friend) fun emit_vault_pause_update_event(arg0: 0x2::object::ID, arg1: bool, arg2: bool, arg3: bool) {
        let v0 = VaultPauseUpdateEvent{
            vault_id        : arg0,
            deposit_paused  : arg1,
            withdraw_paused : arg2,
            claim_paused    : arg3,
        };
        0x2::event::emit<VaultPauseUpdateEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

