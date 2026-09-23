module 0xceae9ac4004d017a43635c8d4ea117488c8bea5635c1f0020c9c0d20edfebfe8::price_feed_btc {
    public fun decimals() : u8 {
        8
    }

    public fun description() : 0x1::string::String {
        0x1::string::utf8(b"RedStone Price Feed for BTC")
    }

    public fun get_data_feed_id() : 0x1::string::String {
        0x1::string::utf8(x"4254430000000000000000000000000000000000000000000000000000000000")
    }

    public fun price_and_timestamp(arg0: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter) : (u256, u64) {
        0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_data::price_and_timestamp(read_price_data(arg0))
    }

    public fun read_price(arg0: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter) : u256 {
        0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_data::price(read_price_data(arg0))
    }

    public fun read_price_data(arg0: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter) : &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_data::PriceData {
        0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::price_data(arg0, x"4254430000000000000000000000000000000000000000000000000000000000")
    }

    // decompiled from Move bytecode v6
}

