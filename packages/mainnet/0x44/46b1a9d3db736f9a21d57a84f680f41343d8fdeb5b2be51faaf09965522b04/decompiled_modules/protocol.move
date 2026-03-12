module 0x4446b1a9d3db736f9a21d57a84f680f41343d8fdeb5b2be51faaf09965522b04::protocol {
    struct HashCommitted has copy, drop {
        committer: address,
        table_name: vector<u8>,
        row_id: vector<u8>,
        data_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct BatchCommitted has copy, drop {
        committer: address,
        merkle_root: vector<u8>,
        leaf_count: u64,
        timestamp_ms: u64,
    }

    public fun commit(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = HashCommitted{
            committer    : 0x2::tx_context::sender(arg4),
            table_name   : arg0,
            row_id       : arg1,
            data_hash    : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<HashCommitted>(v0);
    }

    public fun commit_batch(arg0: vector<u8>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = BatchCommitted{
            committer    : 0x2::tx_context::sender(arg3),
            merkle_root  : arg0,
            leaf_count   : arg1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<BatchCommitted>(v0);
    }

    // decompiled from Move bytecode v6
}

