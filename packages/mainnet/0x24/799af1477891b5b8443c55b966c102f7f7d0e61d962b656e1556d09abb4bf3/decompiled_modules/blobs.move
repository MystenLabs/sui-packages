module 0x24799af1477891b5b8443c55b966c102f7f7d0e61d962b656e1556d09abb4bf3::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BLOBS>(arg0, 6391934365538038642, b"De Blobs", b"Blobs", b"De Blobs Official", b"https://images.hop.ag/ipfs/QmQjb5vmC1Aem2gWmV4Yaxsi8i3sTSmsZfGvn5jMxwv4i2", 0x1::string::utf8(b"https://x.com/De_Blobs"), 0x1::string::utf8(b"https://deblobs.com/"), 0x1::string::utf8(b"https://t.me/De_Blobs"), arg1);
    }

    // decompiled from Move bytecode v6
}

