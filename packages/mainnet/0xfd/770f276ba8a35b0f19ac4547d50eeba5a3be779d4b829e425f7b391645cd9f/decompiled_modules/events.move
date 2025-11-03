module 0xfd770f276ba8a35b0f19ac4547d50eeba5a3be779d4b829e425f7b391645cd9f::events {
    struct TokensClaimed has copy, drop {
        user: address,
        category: u8,
        batch_id: u64,
        total_amount: u64,
        unlocked_amount: u64,
        locked_amount: u64,
        timestamp: u64,
    }

    struct TokensWithdrawn has copy, drop {
        recipient: address,
        amount: u64,
        timestamp: u64,
    }

    struct Paused has copy, drop {
        timestamp: u64,
    }

    struct Unpaused has copy, drop {
        timestamp: u64,
    }

    struct BatchAdded has copy, drop {
        category: u8,
        batch_id: u64,
        merkle_root: vector<u8>,
        timestamp: u64,
    }

    struct BatchRemoved has copy, drop {
        category: u8,
        batch_id: u64,
        timestamp: u64,
    }

    struct TokensDeposited has copy, drop {
        amount: u64,
        timestamp: u64,
    }

    struct AirdropEndTimeSet has copy, drop {
        new_end_time: u64,
        timestamp: u64,
    }

    public(friend) fun emit_airdrop_end_time_set(arg0: u64, arg1: u64) {
        let v0 = AirdropEndTimeSet{
            new_end_time : arg0,
            timestamp    : arg1,
        };
        0x2::event::emit<AirdropEndTimeSet>(v0);
    }

    public(friend) fun emit_batch_added(arg0: u8, arg1: u64, arg2: vector<u8>, arg3: u64) {
        let v0 = BatchAdded{
            category    : arg0,
            batch_id    : arg1,
            merkle_root : arg2,
            timestamp   : arg3,
        };
        0x2::event::emit<BatchAdded>(v0);
    }

    public(friend) fun emit_batch_removed(arg0: u8, arg1: u64, arg2: u64) {
        let v0 = BatchRemoved{
            category  : arg0,
            batch_id  : arg1,
            timestamp : arg2,
        };
        0x2::event::emit<BatchRemoved>(v0);
    }

    public(friend) fun emit_paused(arg0: u64) {
        let v0 = Paused{timestamp: arg0};
        0x2::event::emit<Paused>(v0);
    }

    public(friend) fun emit_tokens_claimed(arg0: address, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = TokensClaimed{
            user            : arg0,
            category        : arg1,
            batch_id        : arg2,
            total_amount    : arg3,
            unlocked_amount : arg4,
            locked_amount   : arg5,
            timestamp       : arg6,
        };
        0x2::event::emit<TokensClaimed>(v0);
    }

    public(friend) fun emit_tokens_deposited(arg0: u64, arg1: u64) {
        let v0 = TokensDeposited{
            amount    : arg0,
            timestamp : arg1,
        };
        0x2::event::emit<TokensDeposited>(v0);
    }

    public(friend) fun emit_tokens_withdrawn(arg0: address, arg1: u64, arg2: u64) {
        let v0 = TokensWithdrawn{
            recipient : arg0,
            amount    : arg1,
            timestamp : arg2,
        };
        0x2::event::emit<TokensWithdrawn>(v0);
    }

    public(friend) fun emit_unpaused(arg0: u64) {
        let v0 = Unpaused{timestamp: arg0};
        0x2::event::emit<Unpaused>(v0);
    }

    // decompiled from Move bytecode v6
}

