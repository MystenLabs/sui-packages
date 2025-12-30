module 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::events {
    struct StreamCreatedEvent has copy, drop {
        stream_id: 0x2::object::ID,
        cancel_cap_id: 0x2::object::ID,
        recipient: address,
        depositer: address,
        total_amount: u64,
        start_time: u64,
        end_time: u64,
        cliff_time: 0x1::option::Option<u64>,
        strategy_type: u8,
        version: u64,
        tranches: 0x1::option::Option<vector<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Tranche>>,
        segments: 0x1::option::Option<vector<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Segment>>,
    }

    struct TokensClaimed has copy, drop {
        stream_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        total_released: u64,
    }

    struct StreamCanceled has copy, drop {
        stream_id: 0x2::object::ID,
        canceled_by: address,
        recipient: address,
        vested_to_recipient: u64,
        unvested_to_depositer: u64,
        canceled_at: u64,
    }

    struct StreamCompletedEvent has copy, drop {
        stream_id: 0x2::object::ID,
        total_claimed: u64,
        completed_at: u64,
    }

    struct FeeCollectedEvent has copy, drop {
        amount: u64,
        recipient: address,
        stream_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct ObjectLockedEvent has copy, drop {
        wrapper_id: 0x2::object::ID,
        locked_object_id: 0x2::object::ID,
        locker: address,
        recipient: address,
        unlock_time: u64,
        version: u64,
    }

    struct ObjectUnlockedEvent has copy, drop {
        wrapper_id: 0x2::object::ID,
        locked_object_id: 0x2::object::ID,
        recipient: address,
        unlocked_at: u64,
    }

    public fun emit_fee_collected(arg0: u64, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>) {
        let v0 = FeeCollectedEvent{
            amount    : arg0,
            recipient : arg1,
            stream_id : arg2,
        };
        0x2::event::emit<FeeCollectedEvent>(v0);
    }

    public fun emit_object_locked(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: u64, arg5: u64) {
        let v0 = ObjectLockedEvent{
            wrapper_id       : arg0,
            locked_object_id : arg1,
            locker           : arg2,
            recipient        : arg3,
            unlock_time      : arg4,
            version          : arg5,
        };
        0x2::event::emit<ObjectLockedEvent>(v0);
    }

    public fun emit_object_unlocked(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = ObjectUnlockedEvent{
            wrapper_id       : arg0,
            locked_object_id : arg1,
            recipient        : arg2,
            unlocked_at      : arg3,
        };
        0x2::event::emit<ObjectUnlockedEvent>(v0);
    }

    public fun emit_stream_canceled(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = StreamCanceled{
            stream_id             : arg0,
            canceled_by           : arg1,
            recipient             : arg2,
            vested_to_recipient   : arg3,
            unvested_to_depositer : arg4,
            canceled_at           : arg5,
        };
        0x2::event::emit<StreamCanceled>(v0);
    }

    public fun emit_stream_completed(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = StreamCompletedEvent{
            stream_id     : arg0,
            total_claimed : arg1,
            completed_at  : arg2,
        };
        0x2::event::emit<StreamCompletedEvent>(v0);
    }

    public fun emit_stream_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: u8, arg9: u64, arg10: 0x1::option::Option<vector<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Tranche>>, arg11: 0x1::option::Option<vector<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Segment>>) {
        let v0 = StreamCreatedEvent{
            stream_id     : arg0,
            cancel_cap_id : arg1,
            recipient     : arg2,
            depositer     : arg3,
            total_amount  : arg4,
            start_time    : arg5,
            end_time      : arg6,
            cliff_time    : arg7,
            strategy_type : arg8,
            version       : arg9,
            tranches      : arg10,
            segments      : arg11,
        };
        0x2::event::emit<StreamCreatedEvent>(v0);
    }

    public fun emit_tokens_claimed(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64) {
        let v0 = TokensClaimed{
            stream_id      : arg0,
            amount         : arg1,
            recipient      : arg2,
            total_released : arg3,
        };
        0x2::event::emit<TokensClaimed>(v0);
    }

    // decompiled from Move bytecode v6
}

