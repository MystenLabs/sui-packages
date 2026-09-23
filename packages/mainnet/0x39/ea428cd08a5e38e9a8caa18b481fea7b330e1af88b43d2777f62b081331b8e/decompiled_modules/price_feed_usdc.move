module 0x39ea428cd08a5e38e9a8caa18b481fea7b330e1af88b43d2777f62b081331b8e::price_feed_usdc {
    public fun decimals() : u8 {
        8
    }

    public fun description() : 0x1::string::String {
        0x1::string::utf8(b"RedStone Price Feed for USDC")
    }

    public fun get_data_feed_id() : 0x1::string::String {
        0x1::string::utf8(x"5553444300000000000000000000000000000000000000000000000000000000")
    }

    public fun price_and_timestamp(arg0: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter) : (u256, u64) {
        0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_data::price_and_timestamp(read_price_data(arg0))
    }

    public fun read_price(arg0: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter) : u256 {
        0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_data::price(read_price_data(arg0))
    }

    public fun read_price_data(arg0: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::PriceAdapter) : &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_data::PriceData {
        0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::price_data(arg0, x"5553444300000000000000000000000000000000000000000000000000000000")
    }

    // decompiled from Move bytecode v6
}

