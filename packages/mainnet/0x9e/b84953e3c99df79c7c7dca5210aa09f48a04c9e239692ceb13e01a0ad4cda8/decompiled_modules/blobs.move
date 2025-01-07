module 0x9eb84953e3c99df79c7c7dca5210aa09f48a04c9e239692ceb13e01a0ad4cda8::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBS>(arg0, 8073460864096894503, b"DeBlobs", b"Blobs", b"$Blobs is more than just a memecoin; it's the start of a new movement on the Sui blockchain. Riding the wave of fun, creativity, and community spirit, $blobs is here to make its mark in the crypto world. As the newest entrant on Hop.fun by hopaggregator, $blobs is set to disrupt the Sui ecosystem, bringing the meme energy with a serious backing.", b"https://images.hop.ag/ipfs/QmSkzH8uTdp7bPWkJCBL6AJUuCx9oeNpRtaP49cicKEDTS", 0x1::string::utf8(b"https://x.com/De_Blobs"), 0x1::string::utf8(b"https://deblobs.com/"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

