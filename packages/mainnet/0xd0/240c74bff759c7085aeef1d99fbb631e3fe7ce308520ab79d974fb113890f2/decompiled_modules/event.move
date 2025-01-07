module 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::event {
    struct PythInitializationEvent has copy, drop {
        dummy_field: bool,
    }

    struct PriceFeedUpdateEvent has copy, drop, store {
        price_feed: 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_feed::PriceFeed,
        timestamp: u64,
    }

    public fun emit_price_feed_update(arg0: 0xd0240c74bff759c7085aeef1d99fbb631e3fe7ce308520ab79d974fb113890f2::price_feed::PriceFeed, arg1: u64) {
        let v0 = PriceFeedUpdateEvent{
            price_feed : arg0,
            timestamp  : arg1,
        };
        0x2::event::emit<PriceFeedUpdateEvent>(v0);
    }

    public(friend) fun emit_pyth_initialization_event() {
        let v0 = PythInitializationEvent{dummy_field: false};
        0x2::event::emit<PythInitializationEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

