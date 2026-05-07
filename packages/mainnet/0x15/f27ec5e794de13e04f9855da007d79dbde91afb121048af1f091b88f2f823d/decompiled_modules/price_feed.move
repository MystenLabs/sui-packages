module 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::price_feed {
    struct PriceFeed has copy, drop, store {
        price_identifier: 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::price_identifier::PriceIdentifier,
        price: 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::price::Price,
        ema_price: 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::price::Price,
    }

    public fun from(arg0: &PriceFeed) : PriceFeed {
        PriceFeed{
            price_identifier : arg0.price_identifier,
            price            : arg0.price,
            ema_price        : arg0.ema_price,
        }
    }

    public fun get_ema_price(arg0: &PriceFeed) : 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::price::Price {
        arg0.ema_price
    }

    public fun get_price(arg0: &PriceFeed) : 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::price::Price {
        arg0.price
    }

    public fun get_price_identifier(arg0: &PriceFeed) : 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::price_identifier::PriceIdentifier {
        arg0.price_identifier
    }

    public fun new(arg0: 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::price_identifier::PriceIdentifier, arg1: 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::price::Price, arg2: 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::price::Price) : PriceFeed {
        PriceFeed{
            price_identifier : arg0,
            price            : arg1,
            ema_price        : arg2,
        }
    }

    // decompiled from Move bytecode v7
}

