module 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_feed {
    struct PriceFeed has copy, drop, store {
        price_identifier: 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_identifier::PriceIdentifier,
        price: 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::Price,
        ema_price: 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::Price,
    }

    public fun from(arg0: &PriceFeed) : PriceFeed {
        PriceFeed{
            price_identifier : arg0.price_identifier,
            price            : arg0.price,
            ema_price        : arg0.ema_price,
        }
    }

    public fun get_ema_price(arg0: &PriceFeed) : 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::Price {
        arg0.ema_price
    }

    public fun get_price(arg0: &PriceFeed) : 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::Price {
        arg0.price
    }

    public fun get_price_identifier(arg0: &PriceFeed) : 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_identifier::PriceIdentifier {
        arg0.price_identifier
    }

    public fun new(arg0: 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_identifier::PriceIdentifier, arg1: 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::Price, arg2: 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::Price) : PriceFeed {
        PriceFeed{
            price_identifier : arg0,
            price            : arg1,
            ema_price        : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

