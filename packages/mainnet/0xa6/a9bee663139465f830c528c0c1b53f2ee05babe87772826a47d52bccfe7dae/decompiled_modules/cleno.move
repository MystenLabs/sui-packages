module 0xa6a9bee663139465f830c528c0c1b53f2ee05babe87772826a47d52bccfe7dae::cleno {
    struct CLENO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLENO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CLENO>(arg0, 10890552788716107219, b"Cleno", b"cleno", b"just a new meme coin, to have fun in trading sui have fun trying to develop skills in trading", b"https://images.hop.ag/ipfs/QmZg4YHf4MToncNjnX9W3yPXbEagcKMqYpP54zQLwZfc8C", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

