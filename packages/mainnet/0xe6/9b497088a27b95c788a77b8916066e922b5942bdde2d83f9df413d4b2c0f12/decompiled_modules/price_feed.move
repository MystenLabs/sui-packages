module 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price_feed {
    struct PriceFeed has copy, drop, store {
        price_identifier: 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price_identifier::PriceIdentifier,
        price: 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price::Price,
        ema_price: 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price::Price,
    }

    public fun from(arg0: &PriceFeed) : PriceFeed {
        PriceFeed{
            price_identifier : arg0.price_identifier,
            price            : arg0.price,
            ema_price        : arg0.ema_price,
        }
    }

    public fun get_ema_price(arg0: &PriceFeed) : 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price::Price {
        arg0.ema_price
    }

    public fun get_price(arg0: &PriceFeed) : 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price::Price {
        arg0.price
    }

    public fun get_price_identifier(arg0: &PriceFeed) : 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price_identifier::PriceIdentifier {
        arg0.price_identifier
    }

    public fun new(arg0: 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price_identifier::PriceIdentifier, arg1: 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price::Price, arg2: 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price::Price) : PriceFeed {
        PriceFeed{
            price_identifier : arg0,
            price            : arg1,
            ema_price        : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

