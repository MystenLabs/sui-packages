module 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed {
    struct PriceFeed has copy, drop, store {
        price_identifier: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier,
        price: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price,
        ema_price: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price,
    }

    public fun from(arg0: &PriceFeed) : PriceFeed {
        PriceFeed{
            price_identifier : arg0.price_identifier,
            price            : arg0.price,
            ema_price        : arg0.ema_price,
        }
    }

    public fun get_ema_price(arg0: &PriceFeed) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price {
        arg0.ema_price
    }

    public fun get_price(arg0: &PriceFeed) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price {
        arg0.price
    }

    public fun get_price_identifier(arg0: &PriceFeed) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier {
        arg0.price_identifier
    }

    public fun new(arg0: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price, arg2: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price) : PriceFeed {
        PriceFeed{
            price_identifier : arg0,
            price            : arg1,
            ema_price        : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

