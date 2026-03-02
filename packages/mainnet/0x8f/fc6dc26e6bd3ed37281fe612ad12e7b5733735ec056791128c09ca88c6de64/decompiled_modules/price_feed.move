module 0x8ffc6dc26e6bd3ed37281fe612ad12e7b5733735ec056791128c09ca88c6de64::price_feed {
    struct PriceFeedComponent has copy, drop, store {
        value: u64,
        update_time: u64,
    }

    struct PriceFeed has copy, drop, store {
        spot: PriceFeedComponent,
        ema: 0x1::option::Option<PriceFeedComponent>,
        twap: 0x1::option::Option<PriceFeedComponent>,
    }

    // decompiled from Move bytecode v6
}

