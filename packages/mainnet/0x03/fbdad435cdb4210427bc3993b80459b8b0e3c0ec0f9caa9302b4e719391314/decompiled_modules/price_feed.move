module 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price_feed {
    struct PriceFeed has copy, drop, store {
        price_identifier: 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price_identifier::PriceIdentifier,
        price: 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price::Price,
        ema_price: 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price::Price,
    }

    public fun from(arg0: &PriceFeed) : PriceFeed {
        PriceFeed{
            price_identifier : arg0.price_identifier,
            price            : arg0.price,
            ema_price        : arg0.ema_price,
        }
    }

    public fun get_ema_price(arg0: &PriceFeed) : 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price::Price {
        arg0.ema_price
    }

    public fun get_price(arg0: &PriceFeed) : 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price::Price {
        arg0.price
    }

    public fun get_price_identifier(arg0: &PriceFeed) : 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price_identifier::PriceIdentifier {
        arg0.price_identifier
    }

    public fun new(arg0: 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price_identifier::PriceIdentifier, arg1: 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price::Price, arg2: 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price::Price) : PriceFeed {
        PriceFeed{
            price_identifier : arg0,
            price            : arg1,
            ema_price        : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

