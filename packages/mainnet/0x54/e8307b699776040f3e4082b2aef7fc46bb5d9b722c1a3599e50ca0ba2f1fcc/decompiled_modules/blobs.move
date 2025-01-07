module 0x54e8307b699776040f3e4082b2aef7fc46bb5d9b722c1a3599e50ca0ba2f1fcc::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBS>(arg0, 3340561104477402277, b"DeBlobs", b"Blobs", b"$blobs is more than just a memecoin; it's the start of a new movement on the Sui blockchain. Riding the wave of fun, creativity, and community spirit, $blobs is here to make its mark in the crypto world.", b"https://images.hop.ag/ipfs/QmZT1gBYYYscEGkHonmg4zsemmWrJRGjfWcNcFzYbPyri1", 0x1::string::utf8(b"https://x.com/De_Blobs"), 0x1::string::utf8(b"https://deblobs.com/"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

