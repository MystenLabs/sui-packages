module 0x2c9cd8892073a4f7bb902bb434f1f0d4ae4763a132728f98ff9b14b2593bdd4d::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBS>(arg0, 17690515572426724401, b"De Blobs", b"Blobs", b"Launch on", b"https://images.hop.ag/ipfs/QmQjb5vmC1Aem2gWmV4Yaxsi8i3sTSmsZfGvn5jMxwv4i2", 0x1::string::utf8(b"https://x.com/De_Blobs"), 0x1::string::utf8(b"https://deblobs.com/"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

