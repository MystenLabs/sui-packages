module 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_feed {
    struct PriceFeed has copy, drop, store {
        price_identifier: 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier,
        price: 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::Price,
        ema_price: 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::Price,
    }

    public fun from(arg0: &PriceFeed) : PriceFeed {
        PriceFeed{
            price_identifier : arg0.price_identifier,
            price            : arg0.price,
            ema_price        : arg0.ema_price,
        }
    }

    public fun get_ema_price(arg0: &PriceFeed) : 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::Price {
        arg0.ema_price
    }

    public fun get_price(arg0: &PriceFeed) : 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::Price {
        arg0.price
    }

    public fun get_price_identifier(arg0: &PriceFeed) : 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier {
        arg0.price_identifier
    }

    public fun new(arg0: 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::PriceIdentifier, arg1: 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::Price, arg2: 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::Price) : PriceFeed {
        PriceFeed{
            price_identifier : arg0,
            price            : arg1,
            ema_price        : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

