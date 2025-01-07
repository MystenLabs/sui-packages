module 0xbf4b13f21694f72e7f75b0e34cada390e5ee4ddf84e8d582fda4da366fdf09cb::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBS>(arg0, 17594869832466312827, b"Deblobs", b"BLOBS", b"$BLOBS is more than just a memecoin; it's the start of a new movement on the Sui blockchain. Riding the wave of fun, creativity, and community spirit, $blobs is here to make its mark in the crypto world.", b"https://images.hop.ag/ipfs/QmUaiF1bzoQ5S1QUAv7eBBg8N3ACywDZnCyHFiHPvaNBs3", 0x1::string::utf8(b"https://x.com/De_Blobs"), 0x1::string::utf8(b"https://deblobs.com/"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

