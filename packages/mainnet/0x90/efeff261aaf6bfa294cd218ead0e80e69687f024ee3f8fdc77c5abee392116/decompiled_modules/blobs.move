module 0x90efeff261aaf6bfa294cd218ead0e80e69687f024ee3f8fdc77c5abee392116::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBS>(arg0, 11089199150171356416, b"DeBlobs", b"blobs", b"$blobs is more than just a memecoin; it's the start of a new movement on the Sui blockchain. Riding the wave of fun, creativity, and community spirit, $blobs is here to make its mark in the crypto world.", b"https://images.hop.ag/ipfs/QmfYUakxs7n2oEHKQaqnWDPXpZ4ymLjMVzzzC1aDyDYANc", 0x1::string::utf8(b"https://x.com/De_Blobs"), 0x1::string::utf8(b"https://deblobs.com/"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

