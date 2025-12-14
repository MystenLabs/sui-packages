module 0xfc8acb280f0d1f7707ef14b34df702506fedc2b83d98acaddb210a116749468f::events {
    struct IntentCreated has copy, drop {
        escrow_id: 0x2::object::ID,
        intent_id: u64,
        user_sui_address: address,
        user_solana_address: vector<u8>,
        input_amount: u64,
        output_token_mint: vector<u8>,
        min_output_amount: u64,
        deadline: u64,
    }

    struct IntentFulfilled has copy, drop {
        escrow_id: 0x2::object::ID,
        intent_id: u64,
        solver_address: address,
        payout_amount: u64,
        fee_amount: u64,
        solana_tx_signature: vector<u8>,
        actual_output_amount: u64,
    }

    struct IntentCancelled has copy, drop {
        escrow_id: 0x2::object::ID,
        intent_id: u64,
        user_address: address,
        refund_amount: u64,
    }

    struct FeeUpdated has copy, drop {
        escrow_id: 0x2::object::ID,
        new_fee_bps: u64,
    }

    struct PauseUpdated has copy, drop {
        escrow_id: 0x2::object::ID,
        paused: bool,
    }

    struct FeesWithdrawn has copy, drop {
        escrow_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    public(friend) fun emit_fee_updated(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = FeeUpdated{
            escrow_id   : arg0,
            new_fee_bps : arg1,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public(friend) fun emit_fees_withdrawn(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = FeesWithdrawn{
            escrow_id : arg0,
            recipient : arg1,
            amount    : arg2,
        };
        0x2::event::emit<FeesWithdrawn>(v0);
    }

    public(friend) fun emit_intent_cancelled(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64) {
        let v0 = IntentCancelled{
            escrow_id     : arg0,
            intent_id     : arg1,
            user_address  : arg2,
            refund_amount : arg3,
        };
        0x2::event::emit<IntentCancelled>(v0);
    }

    public(friend) fun emit_intent_created(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u64) {
        let v0 = IntentCreated{
            escrow_id           : arg0,
            intent_id           : arg1,
            user_sui_address    : arg2,
            user_solana_address : arg3,
            input_amount        : arg4,
            output_token_mint   : arg5,
            min_output_amount   : arg6,
            deadline            : arg7,
        };
        0x2::event::emit<IntentCreated>(v0);
    }

    public(friend) fun emit_intent_fulfilled(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: u64) {
        let v0 = IntentFulfilled{
            escrow_id            : arg0,
            intent_id            : arg1,
            solver_address       : arg2,
            payout_amount        : arg3,
            fee_amount           : arg4,
            solana_tx_signature  : arg5,
            actual_output_amount : arg6,
        };
        0x2::event::emit<IntentFulfilled>(v0);
    }

    public(friend) fun emit_pause_updated(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = PauseUpdated{
            escrow_id : arg0,
            paused    : arg1,
        };
        0x2::event::emit<PauseUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

