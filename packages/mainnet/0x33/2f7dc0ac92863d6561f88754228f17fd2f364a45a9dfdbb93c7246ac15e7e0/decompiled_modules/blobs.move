module 0x332f7dc0ac92863d6561f88754228f17fd2f364a45a9dfdbb93c7246ac15e7e0::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBS>(arg0, 1944522331036827225, b"DeBlobs", b"BLOBS", b"$Blobs is more than just a memecoin; it's the start of a new movement on the Sui blockchain. Riding the wave of fun, creativity, and community spirit, $blobs is here to make its mark in the crypto world. As the newest entrant on Hop.fun by hopaggregator, $blobs is set to disrupt the Sui ecosystem, bringing the meme energy with a serious backing.", b"https://images.hop.ag/ipfs/QmegmHnykmUZv4zkv8xtoAbr8ina5VH6J3pT1ChCqYdXV2", 0x1::string::utf8(b"https://x.com/De_Blobs"), 0x1::string::utf8(b"https://deblobs.com/"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

