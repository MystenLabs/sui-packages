module 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::events {
    struct CreatedVaultEvent has copy, drop {
        vault_id: 0x2::object::ID,
        vault_bank_account: address,
        vault_name: 0x1::string::String,
        max_cap: u64,
        operator: address,
        holding_account: address,
        claims_manager: address,
        vault_type: u8,
    }

    struct VaultOperatorUpdateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        operator: address,
    }

    struct VaultHoldingAccountUpdateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        holding_account: address,
    }

    struct VaultClaimsManagerUpdateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        claims_manager: address,
    }

    struct VaultPauseUpdateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_paused: bool,
        withdraw_paused: bool,
        claim_paused: bool,
    }

    struct VaultMaxCapUpdateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        max_cap: u64,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        sender: address,
        receiver: address,
        amount_deposited: u64,
        user_total_amount: u64,
        vault_total_amount: u64,
        sequence_number: u128,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        receiver: address,
        amount_withdrawn: u64,
        user_pending_withdrawal: u64,
        user_locked_amount: u64,
        total_pending_withdrawal: u64,
        sequence_number: u128,
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
        user_pending_withdraw_amount: u64,
        vault_coin_balance: u64,
        nonce: u128,
        sequence_number: u128,
    }

    struct RewardPoolControllerUpdateEvent has copy, drop {
        pool_id: 0x2::object::ID,
        controller: address,
    }

    struct FundsMovedToVault has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        withdrawal_amount_remaining: u64,
        vault_total_locked_amount: u64,
        vault_coins: u64,
        sequence_number: u128,
    }

    struct ProfitWithdrawRequest has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        total_pending_profit_amount: u64,
        sequence_number: u128,
    }

    struct ProfitMovedToHoldingAccount has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        total_pending_profit_amount: u64,
        sequence_number: u128,
    }

    struct NonceMarkedAsClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        nonce: u128,
    }

    public(friend) fun emit_created_rewards_pool_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = CreatedRewardsPoolEvent{
            pool_id    : arg0,
            controller : arg1,
        };
        0x2::event::emit<CreatedRewardsPoolEvent>(v0);
    }

    public(friend) fun emit_created_vault_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: address, arg6: address, arg7: u8) {
        let v0 = CreatedVaultEvent{
            vault_id           : arg0,
            vault_bank_account : arg1,
            vault_name         : arg2,
            max_cap            : arg3,
            operator           : arg4,
            holding_account    : arg5,
            claims_manager     : arg6,
            vault_type         : arg7,
        };
        0x2::event::emit<CreatedVaultEvent>(v0);
    }

    public(friend) fun emit_funds_claimed_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128) {
        let v0 = FundsClaimedEvent{
            vault_id                     : arg0,
            caller                       : arg1,
            receiver                     : arg2,
            amount                       : arg3,
            user_pending_withdraw_amount : arg4,
            vault_coin_balance           : arg5,
            nonce                        : arg6,
            sequence_number              : arg7,
        };
        0x2::event::emit<FundsClaimedEvent>(v0);
    }

    public(friend) fun emit_funds_deposited_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u128) {
        let v0 = DepositEvent{
            vault_id           : arg0,
            sender             : arg1,
            receiver           : arg2,
            amount_deposited   : arg3,
            user_total_amount  : arg4,
            vault_total_amount : arg5,
            sequence_number    : arg6,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public(friend) fun emit_funds_moved_to_vault_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u128) {
        let v0 = FundsMovedToVault{
            vault_id                    : arg0,
            amount                      : arg1,
            withdrawal_amount_remaining : arg2,
            vault_total_locked_amount   : arg3,
            vault_coins                 : arg4,
            sequence_number             : arg5,
        };
        0x2::event::emit<FundsMovedToVault>(v0);
    }

    public(friend) fun emit_funds_withdrawn_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128) {
        let v0 = WithdrawEvent{
            vault_id                 : arg0,
            receiver                 : arg1,
            amount_withdrawn         : arg2,
            user_pending_withdrawal  : arg3,
            user_locked_amount       : arg4,
            total_pending_withdrawal : arg5,
            sequence_number          : arg6,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    public(friend) fun emit_nonce_marked_as_claimed(arg0: 0x2::object::ID, arg1: u128) {
        let v0 = NonceMarkedAsClaimed{
            pool_id : arg0,
            nonce   : arg1,
        };
        0x2::event::emit<NonceMarkedAsClaimed>(v0);
    }

    public(friend) fun emit_profit_withdraw_request(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128) {
        let v0 = ProfitWithdrawRequest{
            vault_id                    : arg0,
            amount                      : arg1,
            total_pending_profit_amount : arg2,
            sequence_number             : arg3,
        };
        0x2::event::emit<ProfitWithdrawRequest>(v0);
    }

    public(friend) fun emit_profits_moved_to_holding_account(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128) {
        let v0 = ProfitMovedToHoldingAccount{
            vault_id                    : arg0,
            amount                      : arg1,
            total_pending_profit_amount : arg2,
            sequence_number             : arg3,
        };
        0x2::event::emit<ProfitMovedToHoldingAccount>(v0);
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

    public(friend) fun emit_vault_claims_manager_update_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = VaultClaimsManagerUpdateEvent{
            vault_id       : arg0,
            claims_manager : arg1,
        };
        0x2::event::emit<VaultClaimsManagerUpdateEvent>(v0);
    }

    public(friend) fun emit_vault_holding_account_update_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = VaultHoldingAccountUpdateEvent{
            vault_id        : arg0,
            holding_account : arg1,
        };
        0x2::event::emit<VaultHoldingAccountUpdateEvent>(v0);
    }

    public(friend) fun emit_vault_max_cap_updated(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = VaultMaxCapUpdateEvent{
            vault_id : arg0,
            max_cap  : arg1,
        };
        0x2::event::emit<VaultMaxCapUpdateEvent>(v0);
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

