module 0x9a056656cca097b24eea835fb773a8f4514b773fd8ddd2ffafd11ee1dc86e192::lock_recorder {
    struct LoyaltyRewardLockEvent has copy, drop, store {
        ve_sca_key_id: 0x2::object::ID,
        amount: u64,
    }

    public fun record_lock_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = LoyaltyRewardLockEvent{
            ve_sca_key_id : arg0,
            amount        : arg1,
        };
        0x2::event::emit<LoyaltyRewardLockEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

