module 0x31086789cae6b68f6b67ad33ecee17ed6d8527069c2238eb118800ee8bfcf2f9::bubbo {
    struct BUBBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BUBBO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BUBBO>(arg0, b"BUBBO", b"Bubbo", b"All-in-One Crypto Tracker", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfHDhDdZkm8ePrHrAkMy4woxDbVZRzmBpr1cRU6MKqPix")), b"https://www.bubbo.fun/", b"https://x.com/bubbofun", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000a41d18c3cf0a6aeb60e3a5c0e60431244b0633f62c264a2a5071e498b8139595567b69764ab2268062ed0f64bb673812352d8f37d23f8c6f05073d03ae9d20fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747833012"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

