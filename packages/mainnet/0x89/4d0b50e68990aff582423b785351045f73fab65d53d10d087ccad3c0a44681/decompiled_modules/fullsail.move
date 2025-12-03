module 0x894d0b50e68990aff582423b785351045f73fab65d53d10d087ccad3c0a44681::fullsail {
    public fun get_sqrt_price_at_tick(arg0: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32) : 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32 {
        arg0
    }

    public fun new_random(arg0: u64) : 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::random::Random {
        0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::random::new(arg0)
    }

    public fun str(arg0: u64) : 0x1::string::String {
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::utils::str(arg0)
    }

    // decompiled from Move bytecode v6
}

