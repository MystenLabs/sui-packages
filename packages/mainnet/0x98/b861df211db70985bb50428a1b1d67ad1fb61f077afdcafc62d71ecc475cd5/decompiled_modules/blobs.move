module 0x98b861df211db70985bb50428a1b1d67ad1fb61f077afdcafc62d71ecc475cd5::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBS>(arg0, 2047353864884499798, b"De Blobs", b"BLOBS", b"$blobs is more than just a memecoin; it's the start of a new movement on the Sui blockchain. Riding the wave of fun, creativity, and community spirit, $blobs is here to make its mark in the crypto world.", b"https://images.hop.ag/ipfs/QmabugYPa7Y8tCV8F1BBeEzt1QvJSpAe6L5paiTeZuW1pr", 0x1::string::utf8(b"https://x.com/De_Blobs"), 0x1::string::utf8(b"https://deblobs.com/"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

