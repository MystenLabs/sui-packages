module 0xc6fe29219d53e6c9c496760ba6267e7f279c5d23a37529fdc8761ce168243145::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBS>(arg0, 8042361802522467484, b"DeBlobs", b"Blobs", b"$Blobs is more than just a memecoin; it's the start of a new movement on the Sui blockchain. Riding the wave of fun, creativity, and community spirit, $blobs is here to make its mark in the crypto world. As the newest entrant on Hop.fun by hopaggregator, $blobs is set to disrupt the Sui ecosystem, bringing the meme energy with a serious backing.", b"https://images.hop.ag/ipfs/QmXLsASqRz4G4vQWjSVfreSkjaptMy3A14BR7QrA8eqkXk", 0x1::string::utf8(b"https://x.com/De_Blobs"), 0x1::string::utf8(b"https://deblobs.com/"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

