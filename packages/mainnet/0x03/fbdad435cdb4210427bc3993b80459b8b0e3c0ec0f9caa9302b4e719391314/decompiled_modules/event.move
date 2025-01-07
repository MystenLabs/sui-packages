module 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::event {
    struct PythInitializationEvent has copy, drop {
        dummy_field: bool,
    }

    struct PriceFeedUpdateEvent has copy, drop, store {
        price_feed: 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price_feed::PriceFeed,
        timestamp: u64,
    }

    public(friend) fun emit_price_feed_update(arg0: 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price_feed::PriceFeed, arg1: u64) {
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

