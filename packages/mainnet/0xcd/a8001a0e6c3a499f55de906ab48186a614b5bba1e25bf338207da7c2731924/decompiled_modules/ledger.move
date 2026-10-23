module 0xcda8001a0e6c3a499f55de906ab48186a614b5bba1e25bf338207da7c2731924::ledger {
    struct ResolverCap has store, key {
        id: 0x2::object::UID,
    }

    struct BatchCommitted has copy, drop {
        market_id: 0x1::string::String,
        batch_hash: vector<u8>,
        pick_count: u64,
        committed_at_ms: u64,
    }

    struct ResultPosted has copy, drop {
        market_id: 0x1::string::String,
        winner: 0x1::string::String,
        score: 0x1::string::String,
        posted_at_ms: u64,
    }

    public fun commit_batch(arg0: &ResolverCap, arg1: 0x1::string::String, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = BatchCommitted{
            market_id       : arg1,
            batch_hash      : arg2,
            pick_count      : arg3,
            committed_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BatchCommitted>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ResolverCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ResolverCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun post_result(arg0: &ResolverCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) {
        let v0 = ResultPosted{
            market_id    : arg1,
            winner       : arg2,
            score        : arg3,
            posted_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ResultPosted>(v0);
    }

    // decompiled from Move bytecode v7
}

