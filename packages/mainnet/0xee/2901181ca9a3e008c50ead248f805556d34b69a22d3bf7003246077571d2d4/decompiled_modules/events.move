module 0x8d378268233c9cdc636b7820fd45de7ba4d9ad92835c2391d3b24d4d2332e790::events {
    struct NewCenterEvent<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        min_unlocking_duration: u64,
        max_unlocking_duration: u64,
        base_percentage: u8,
    }

    struct LockEvent<phantom T0> has copy, drop {
        de_token_id: 0x2::object::ID,
        locked_balance: u64,
    }

    struct RequestUnlocKEvent<phantom T0> has copy, drop {
        de_token_id: 0x2::object::ID,
        unlocked_balance: u64,
        unlocked_duration: u64,
        unlocked_at: u64,
        timestamp: u64,
    }

    struct CancelUnlocKEvent<phantom T0> has copy, drop {
        de_token_id: 0x2::object::ID,
        unlocked_balance: u64,
        unlocked_duration: u64,
        start_at: u64,
        unlocked_at: u64,
        timestamp: u64,
    }

    struct ClaimEvent<phantom T0> has copy, drop {
        de_token_id: 0x2::object::ID,
        withdrawal: u64,
        penalty: u64,
        start_at: u64,
        unlocked_at: u64,
        timestamp: u64,
    }

    struct BurnEvent<phantom T0> has copy, drop {
        de_token_id: 0x2::object::ID,
    }

    public fun emit_burn_event<T0>(arg0: 0x2::object::ID) {
        let v0 = BurnEvent<T0>{de_token_id: arg0};
        0x2::event::emit<BurnEvent<T0>>(v0);
    }

    public fun emit_cancel_unlock_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = CancelUnlocKEvent<T0>{
            de_token_id       : arg0,
            unlocked_balance  : arg1,
            unlocked_duration : arg2,
            start_at          : arg3,
            unlocked_at       : arg4,
            timestamp         : arg5,
        };
        0x2::event::emit<CancelUnlocKEvent<T0>>(v0);
    }

    public fun emit_claim_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = ClaimEvent<T0>{
            de_token_id : arg0,
            withdrawal  : arg1,
            penalty     : arg2,
            start_at    : arg3,
            unlocked_at : arg4,
            timestamp   : arg5,
        };
        0x2::event::emit<ClaimEvent<T0>>(v0);
    }

    public fun emit_lock_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = LockEvent<T0>{
            de_token_id    : arg0,
            locked_balance : arg1,
        };
        0x2::event::emit<LockEvent<T0>>(v0);
    }

    public fun emit_new_center_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u8) {
        let v0 = NewCenterEvent<T0>{
            id                     : arg0,
            min_unlocking_duration : arg1,
            max_unlocking_duration : arg2,
            base_percentage        : arg3,
        };
        0x2::event::emit<NewCenterEvent<T0>>(v0);
    }

    public fun emit_request_unlock_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = RequestUnlocKEvent<T0>{
            de_token_id       : arg0,
            unlocked_balance  : arg1,
            unlocked_duration : arg2,
            unlocked_at       : arg3,
            timestamp         : arg4,
        };
        0x2::event::emit<RequestUnlocKEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

