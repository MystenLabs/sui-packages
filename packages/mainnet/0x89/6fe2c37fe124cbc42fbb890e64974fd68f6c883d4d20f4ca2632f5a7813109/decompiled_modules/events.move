module 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::events {
    struct VaultInitialized has copy, drop {
        vault_id: 0x2::object::ID,
        index: u64,
        min_deposit: u64,
        withdraw_fee: u64,
    }

    struct VrfAuthorityUpdated has copy, drop {
        old: address,
        new: address,
    }

    struct AdminTransferProposed has copy, drop {
        current: address,
        proposed: address,
    }

    struct AdminTransferred has copy, drop {
        old: address,
        new: address,
    }

    struct WithdrawFeeUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        old: u64,
        new: u64,
    }

    struct FeeCollected has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    struct CommitEvent has copy, drop {
        vault_id: 0x2::object::ID,
        reward_id: 0x2::object::ID,
        round: u64,
        reward_type: u8,
        total_tickets: u64,
        amount: u64,
        merkle_root: vector<u8>,
        vrf_input: vector<u8>,
        secret_hash: vector<u8>,
        vrf_pubkey: vector<u8>,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
        new_user_shares: u64,
        new_total_shares: u64,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        withdrawer: address,
        shares_burned: u64,
        underlying_returned: u64,
        fee: u64,
        new_user_shares: u64,
        new_total_shares: u64,
    }

    struct ClaimEvent has copy, drop {
        vault_id: 0x2::object::ID,
        reward_id: 0x2::object::ID,
        round: u64,
        claimer: address,
        amount: u64,
    }

    struct RewardExpired has copy, drop {
        vault_id: 0x2::object::ID,
        reward_id: 0x2::object::ID,
        round: u64,
        amount: u64,
    }

    struct RevealEvent has copy, drop {
        vault_id: 0x2::object::ID,
        reward_id: 0x2::object::ID,
        round: u64,
        secret_seed: vector<u8>,
        vrf_output: vector<u8>,
        winner_index: u64,
        winner: address,
        winner_start: u64,
        winner_count: u64,
    }

    public(friend) fun emit_admin_transfer_proposed(arg0: address, arg1: address) {
        let v0 = AdminTransferProposed{
            current  : arg0,
            proposed : arg1,
        };
        0x2::event::emit<AdminTransferProposed>(v0);
    }

    public(friend) fun emit_admin_transferred(arg0: address, arg1: address) {
        let v0 = AdminTransferred{
            old : arg0,
            new : arg1,
        };
        0x2::event::emit<AdminTransferred>(v0);
    }

    public(friend) fun emit_claim(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: u64) {
        let v0 = ClaimEvent{
            vault_id  : arg0,
            reward_id : arg1,
            round     : arg2,
            claimer   : arg3,
            amount    : arg4,
        };
        0x2::event::emit<ClaimEvent>(v0);
    }

    public(friend) fun emit_commit(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>) {
        let v0 = CommitEvent{
            vault_id      : arg0,
            reward_id     : arg1,
            round         : arg2,
            reward_type   : arg3,
            total_tickets : arg4,
            amount        : arg5,
            merkle_root   : arg6,
            vrf_input     : arg7,
            secret_hash   : arg8,
            vrf_pubkey    : arg9,
        };
        0x2::event::emit<CommitEvent>(v0);
    }

    public(friend) fun emit_deposit(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = DepositEvent{
            vault_id         : arg0,
            depositor        : arg1,
            amount           : arg2,
            new_user_shares  : arg3,
            new_total_shares : arg4,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public(friend) fun emit_fee_collected(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = FeeCollected{
            vault_id  : arg0,
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<FeeCollected>(v0);
    }

    public(friend) fun emit_reveal(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: address, arg7: u64, arg8: u64) {
        let v0 = RevealEvent{
            vault_id     : arg0,
            reward_id    : arg1,
            round        : arg2,
            secret_seed  : arg3,
            vrf_output   : arg4,
            winner_index : arg5,
            winner       : arg6,
            winner_start : arg7,
            winner_count : arg8,
        };
        0x2::event::emit<RevealEvent>(v0);
    }

    public(friend) fun emit_reward_expired(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = RewardExpired{
            vault_id  : arg0,
            reward_id : arg1,
            round     : arg2,
            amount    : arg3,
        };
        0x2::event::emit<RewardExpired>(v0);
    }

    public(friend) fun emit_vault_initialized(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = VaultInitialized{
            vault_id     : arg0,
            index        : arg1,
            min_deposit  : arg2,
            withdraw_fee : arg3,
        };
        0x2::event::emit<VaultInitialized>(v0);
    }

    public(friend) fun emit_vrf_authority_updated(arg0: address, arg1: address) {
        let v0 = VrfAuthorityUpdated{
            old : arg0,
            new : arg1,
        };
        0x2::event::emit<VrfAuthorityUpdated>(v0);
    }

    public(friend) fun emit_withdraw(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = WithdrawEvent{
            vault_id            : arg0,
            withdrawer          : arg1,
            shares_burned       : arg2,
            underlying_returned : arg3,
            fee                 : arg4,
            new_user_shares     : arg5,
            new_total_shares    : arg6,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    public(friend) fun emit_withdraw_fee_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = WithdrawFeeUpdated{
            vault_id : arg0,
            old      : arg1,
            new      : arg2,
        };
        0x2::event::emit<WithdrawFeeUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

