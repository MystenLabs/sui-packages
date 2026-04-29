module 0xcba7b896eacaa32775efe0fec171c3478df61e61f55877f4da09a9fd3b51a28f::fake_bridge_event {
    struct TokenDepositedEvent has copy, drop {
        seq_num: u64,
        source_chain: u8,
        sender_address: vector<u8>,
        target_chain: u8,
        target_address: vector<u8>,
        token_type: u8,
        amount: u64,
    }

    struct TokenDepositedEventV2 has copy, drop {
        seq_num: u64,
        source_chain: u8,
        sender_address: vector<u8>,
        target_chain: u8,
        target_address: vector<u8>,
        token_type: u8,
        amount: u64,
        timestamp_ms: u64,
    }

    public fun emit_fake_deposit(arg0: vector<u8>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = TokenDepositedEvent{
            seq_num        : 888888,
            source_chain   : 1,
            sender_address : 0x2::address::to_bytes(0x2::tx_context::sender(arg2)),
            target_chain   : 2,
            target_address : arg0,
            token_type     : 1,
            amount         : arg1,
        };
        0x2::event::emit<TokenDepositedEvent>(v0);
    }

    public fun emit_fake_deposit_v2(arg0: vector<u8>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = TokenDepositedEventV2{
            seq_num        : 888889,
            source_chain   : 1,
            sender_address : 0x2::address::to_bytes(0x2::tx_context::sender(arg2)),
            target_chain   : 2,
            target_address : arg0,
            token_type     : 1,
            amount         : arg1,
            timestamp_ms   : 1746000000000,
        };
        0x2::event::emit<TokenDepositedEventV2>(v0);
    }

    // decompiled from Move bytecode v7
}

