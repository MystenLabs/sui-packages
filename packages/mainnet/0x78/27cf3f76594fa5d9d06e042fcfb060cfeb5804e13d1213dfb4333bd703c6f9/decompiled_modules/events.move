module 0x7827cf3f76594fa5d9d06e042fcfb060cfeb5804e13d1213dfb4333bd703c6f9::events {
    struct CreatedVaultEvent has copy, drop {
        vault_id: 0x2::object::ID,
        perpetual_name: 0x1::string::String,
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
    }

    struct RequestQueuedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        sender: address,
        receiver: address,
        amount: u64,
        total_amount_in_vault: u64,
        queue_pointer: u128,
        queue_size: u128,
        type: u8,
    }

    struct RequestProcessedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        sender: address,
        receiver: address,
        amount: u64,
        queue_pointer: u128,
        type: u8,
    }

    struct FundsClaimedEvent has copy, drop {
        caller: address,
        receiver: address,
        amount: u64,
    }

    public(friend) fun emit_created_vault_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: address) {
        let v0 = CreatedVaultEvent{
            vault_id       : arg0,
            perpetual_name : arg1,
            operator       : arg2,
        };
        0x2::event::emit<CreatedVaultEvent>(v0);
    }

    public(friend) fun emit_event_processed_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u128, arg5: u8) {
        let v0 = RequestProcessedEvent{
            vault_id      : arg0,
            sender        : arg1,
            receiver      : arg2,
            amount        : arg3,
            queue_pointer : arg4,
            type          : arg5,
        };
        0x2::event::emit<RequestProcessedEvent>(v0);
    }

    public(friend) fun emit_funds_claimed_event(arg0: address, arg1: address, arg2: u64) {
        let v0 = FundsClaimedEvent{
            caller   : arg0,
            receiver : arg1,
            amount   : arg2,
        };
        0x2::event::emit<FundsClaimedEvent>(v0);
    }

    public(friend) fun emit_request_queued_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u8) {
        let v0 = RequestQueuedEvent{
            vault_id              : arg0,
            sender                : arg1,
            receiver              : arg2,
            amount                : arg3,
            total_amount_in_vault : arg4,
            queue_pointer         : arg5,
            queue_size            : arg6,
            type                  : arg7,
        };
        0x2::event::emit<RequestQueuedEvent>(v0);
    }

    public(friend) fun emit_vault_operator_update_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = VaultOperatorUpdateEvent{
            vault_id : arg0,
            operator : arg1,
        };
        0x2::event::emit<VaultOperatorUpdateEvent>(v0);
    }

    public(friend) fun emit_vault_pause_update_event(arg0: 0x2::object::ID, arg1: bool, arg2: bool) {
        let v0 = VaultPauseUpdateEvent{
            vault_id        : arg0,
            deposit_paused  : arg1,
            withdraw_paused : arg2,
        };
        0x2::event::emit<VaultPauseUpdateEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

