module 0xb57c5ecb87de8ecec7add3779a372befa4d61d89851cf97b8246a676de5b738d::inv {
    struct INV has drop {
        dummy_field: bool,
    }

    fun init(arg0: INV, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<INV>(arg0, 3890384826179208864, b"INVICTUS", b"INV", b"No limit", b"https://images.hop.ag/ipfs/QmcoeyBZUixFotjzw9vQDajafHciVhD1tAB2u8bd9Krcs4", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/invictus_coin"), arg1);
    }

    // decompiled from Move bytecode v6
}

