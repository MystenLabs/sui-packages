module 0xbac443c2fffdd8f020d11b038f5919c493659a14734d347a35155ac83b31c5a3::ghost {
    struct GHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOST, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<GHOST>(arg0, 11974414404552188045, b"Ghostbusters 2", b"GHOST", b"the Ghostbusters token is made to pay homage to the best films of all time", b"https://images.hop.ag/ipfs/QmbXwCECjHtGT6rBfcjU3mTQPckdwAkDFqYvcejVXnn3Hd", 0x1::string::utf8(b"https://x.com/AntoineRoutier8"), 0x1::string::utf8(b"https://www.ghostbustershq.net/home/tag/ghostbusters+2"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

