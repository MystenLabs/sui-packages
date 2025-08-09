module 0xfe831defb8bb984e6af60bde8234201adbc555b2378f64b130d32cd9eba1ac21::events {
    struct NewCenterEvent<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        min_unlocking_duration: u64,
        max_unlocking_duration: u64,
        base_percentage: u8,
    }

    struct UpdateDuration<phantom T0> has copy, drop {
        de_center_id: 0x2::object::ID,
        min_duration: u64,
        max_duration: u64,
    }

    struct UpdateMinReturnPercentageRate<phantom T0> has copy, drop {
        de_center_id: 0x2::object::ID,
        min_return_percentage_rate: u8,
    }

    struct WithdrawPenaltyFee<phantom T0> has copy, drop {
        de_center_id: 0x2::object::ID,
        value: u64,
    }

    struct LockEvent<phantom T0> has copy, drop {
        de_token_id: 0x2::object::ID,
        locked_balance: u64,
    }

    struct IncreaseLockedAmountEvent<phantom T0> has copy, drop {
        de_token_id: 0x2::object::ID,
        locked_balance: u64,
    }

    struct RequestUnlockEvent<phantom T0> has copy, drop {
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

    public(friend) fun emit_burn_event<T0>(arg0: 0x2::object::ID) {
        let v0 = BurnEvent<T0>{de_token_id: arg0};
        0x2::event::emit<BurnEvent<T0>>(v0);
    }

    public(friend) fun emit_cancel_unlock_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
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

    public(friend) fun emit_claim_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
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

    public(friend) fun emit_increase_locked_amount_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = IncreaseLockedAmountEvent<T0>{
            de_token_id    : arg0,
            locked_balance : arg1,
        };
        0x2::event::emit<IncreaseLockedAmountEvent<T0>>(v0);
    }

    public(friend) fun emit_lock_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = LockEvent<T0>{
            de_token_id    : arg0,
            locked_balance : arg1,
        };
        0x2::event::emit<LockEvent<T0>>(v0);
    }

    public(friend) fun emit_new_center_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u8) {
        let v0 = NewCenterEvent<T0>{
            id                     : arg0,
            min_unlocking_duration : arg1,
            max_unlocking_duration : arg2,
            base_percentage        : arg3,
        };
        0x2::event::emit<NewCenterEvent<T0>>(v0);
    }

    public(friend) fun emit_request_unlock_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = RequestUnlockEvent<T0>{
            de_token_id       : arg0,
            unlocked_balance  : arg1,
            unlocked_duration : arg2,
            unlocked_at       : arg3,
            timestamp         : arg4,
        };
        0x2::event::emit<RequestUnlockEvent<T0>>(v0);
    }

    public(friend) fun emit_update_duration<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = UpdateDuration<T0>{
            de_center_id : arg0,
            min_duration : arg1,
            max_duration : arg2,
        };
        0x2::event::emit<UpdateDuration<T0>>(v0);
    }

    public(friend) fun emit_update_min_return_percentage_rate<T0>(arg0: 0x2::object::ID, arg1: u8) {
        let v0 = UpdateMinReturnPercentageRate<T0>{
            de_center_id               : arg0,
            min_return_percentage_rate : arg1,
        };
        0x2::event::emit<UpdateMinReturnPercentageRate<T0>>(v0);
    }

    public(friend) fun emit_withdraw_penalty_fee<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = WithdrawPenaltyFee<T0>{
            de_center_id : arg0,
            value        : arg1,
        };
        0x2::event::emit<WithdrawPenaltyFee<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

