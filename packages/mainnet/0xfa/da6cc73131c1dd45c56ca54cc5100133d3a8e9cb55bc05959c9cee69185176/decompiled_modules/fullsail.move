module 0xfada6cc73131c1dd45c56ca54cc5100133d3a8e9cb55bc05959c9cee69185176::fullsail {
    public fun get_sqrt_price_at_tick(arg0: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32) : 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32 {
        arg0
    }

    public fun new_random(arg0: u64) : 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::random::Random {
        0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::random::new(arg0)
    }

    // decompiled from Move bytecode v6
}

