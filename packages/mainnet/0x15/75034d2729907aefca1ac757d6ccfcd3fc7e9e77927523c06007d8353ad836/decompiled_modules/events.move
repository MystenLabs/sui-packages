module 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::events {
    struct CreatedStakedSuiVaultEvent has copy, drop {
        staking_entity_id: 0x2::object::ID,
    }

    struct StakedEvent has copy, drop {
        staker: address,
        validator: address,
        staked_sui_id: 0x2::object::ID,
        sui_id: 0x2::object::ID,
        sui_amount: u64,
        afsui_id: 0x2::object::ID,
        afsui_amount: u64,
        validator_fee: u64,
        referrer: 0x1::option::Option<address>,
        epoch: u64,
        is_restaked: bool,
    }

    struct UnstakeRequestedEvent has copy, drop {
        afsui_id: 0x2::object::ID,
        provided_afsui_amount: u64,
        requester: address,
        epoch: u64,
    }

    struct UnstakedEvent has copy, drop {
        afsui_id: 0x2::object::ID,
        provided_afsui_amount: u64,
        sui_id: 0x2::object::ID,
        returned_sui_amount: u64,
        requester: 0x1::option::Option<address>,
        epoch: u64,
    }

    struct OneRoundOfEpochProcessingFinished has copy, drop {
        staking_entity_id: 0x2::object::ID,
        epoch: u64,
        is_epoch_processing: bool,
        is_pending_unstakes_processed: bool,
        is_unstaking_deque_sorted: bool,
    }

    struct EpochWasChangedEvent has copy, drop {
        active_epoch: u64,
        total_sui_amount: u64,
        total_rewards_amount: u64,
        total_afsui_supply: u64,
    }

    public(friend) fun emit_created_staked_sui_vault_event(arg0: 0x2::object::ID) {
        let v0 = CreatedStakedSuiVaultEvent{staking_entity_id: arg0};
        0x2::event::emit<CreatedStakedSuiVaultEvent>(v0);
    }

    public(friend) fun emit_epoch_was_changed_event(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = EpochWasChangedEvent{
            active_epoch         : arg0,
            total_sui_amount     : arg1,
            total_rewards_amount : arg2,
            total_afsui_supply   : arg3,
        };
        0x2::event::emit<EpochWasChangedEvent>(v0);
    }

    public(friend) fun emit_one_round_of_epoch_processing_finished_event(arg0: 0x2::object::ID, arg1: u64, arg2: bool, arg3: bool, arg4: bool) {
        let v0 = OneRoundOfEpochProcessingFinished{
            staking_entity_id             : arg0,
            epoch                         : arg1,
            is_epoch_processing           : arg2,
            is_pending_unstakes_processed : arg3,
            is_unstaking_deque_sorted     : arg4,
        };
        0x2::event::emit<OneRoundOfEpochProcessingFinished>(v0);
    }

    public(friend) fun emit_staked_event(arg0: address, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: 0x1::option::Option<address>, arg9: u64, arg10: bool) {
        let v0 = StakedEvent{
            staker        : arg0,
            validator     : arg1,
            staked_sui_id : arg2,
            sui_id        : arg3,
            sui_amount    : arg4,
            afsui_id      : arg5,
            afsui_amount  : arg6,
            validator_fee : arg7,
            referrer      : arg8,
            epoch         : arg9,
            is_restaked   : arg10,
        };
        0x2::event::emit<StakedEvent>(v0);
    }

    public(friend) fun emit_unstake_requested_event(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64) {
        let v0 = UnstakeRequestedEvent{
            afsui_id              : arg0,
            provided_afsui_amount : arg1,
            requester             : arg2,
            epoch                 : arg3,
        };
        0x2::event::emit<UnstakeRequestedEvent>(v0);
    }

    public(friend) fun emit_unstaked_event(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::option::Option<address>, arg5: u64) {
        let v0 = UnstakedEvent{
            afsui_id              : arg0,
            provided_afsui_amount : arg1,
            sui_id                : arg2,
            returned_sui_amount   : arg3,
            requester             : arg4,
            epoch                 : arg5,
        };
        0x2::event::emit<UnstakedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

