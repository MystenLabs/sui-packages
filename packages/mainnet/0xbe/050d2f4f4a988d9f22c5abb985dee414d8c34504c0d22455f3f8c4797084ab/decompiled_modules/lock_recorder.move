module 0xbe050d2f4f4a988d9f22c5abb985dee414d8c34504c0d22455f3f8c4797084ab::lock_recorder {
    struct LoyaltayRewardLockEvent has copy, drop, store {
        amount: u64,
    }

    public fun record_lock_event(arg0: u64) {
        let v0 = LoyaltayRewardLockEvent{amount: arg0};
        0x2::event::emit<LoyaltayRewardLockEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

