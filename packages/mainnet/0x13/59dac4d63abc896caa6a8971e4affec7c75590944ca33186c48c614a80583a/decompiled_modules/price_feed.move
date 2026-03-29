module 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::price_feed {
    struct PriceFeed has copy, drop, store {
        price_identifier: 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::price_identifier::PriceIdentifier,
        price: 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::price::Price,
        ema_price: 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::price::Price,
    }

    public fun from(arg0: &PriceFeed) : PriceFeed {
        PriceFeed{
            price_identifier : arg0.price_identifier,
            price            : arg0.price,
            ema_price        : arg0.ema_price,
        }
    }

    public fun get_ema_price(arg0: &PriceFeed) : 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::price::Price {
        arg0.ema_price
    }

    public fun get_price(arg0: &PriceFeed) : 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::price::Price {
        arg0.price
    }

    public fun get_price_identifier(arg0: &PriceFeed) : 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::price_identifier::PriceIdentifier {
        arg0.price_identifier
    }

    public fun new(arg0: 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::price_identifier::PriceIdentifier, arg1: 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::price::Price, arg2: 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::price::Price) : PriceFeed {
        PriceFeed{
            price_identifier : arg0,
            price            : arg1,
            ema_price        : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

