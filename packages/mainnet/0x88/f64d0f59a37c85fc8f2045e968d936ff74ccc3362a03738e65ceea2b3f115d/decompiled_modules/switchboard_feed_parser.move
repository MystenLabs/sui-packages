module 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::switchboard_feed_parser {
    struct AggregatorInfo has copy, drop {
        aggregator_addr: address,
        latest_result: u128,
        latest_result_scaling_factor: u8,
        latest_timestamp: u64,
        negative: bool,
    }

    // decompiled from Move bytecode v6
}

