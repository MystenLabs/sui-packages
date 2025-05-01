module 0x6d3c234d9b4895cb55f696ffb163ec7c6d861b8037d09eb129516052e00602d4::lock_recorder {
    struct LoyaltyRewardLockEvent has copy, drop, store {
        amount: u64,
    }

    public fun record_lock_event(arg0: u64) {
        let v0 = LoyaltyRewardLockEvent{amount: arg0};
        0x2::event::emit<LoyaltyRewardLockEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

