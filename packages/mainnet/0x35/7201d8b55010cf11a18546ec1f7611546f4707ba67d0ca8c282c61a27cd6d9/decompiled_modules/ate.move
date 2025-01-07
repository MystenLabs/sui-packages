module 0x357201d8b55010cf11a18546ec1f7611546f4707ba67d0ca8c282c61a27cd6d9::ate {
    struct ATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ATE>(arg0, 1069935864772815458, b"ate", b"ate", b"the best coin", b"https://images.hop.ag/ipfs/QmWvbbZ5mYoF5Mmg5j5HZSsVLHjqfZybQ22uPqggb5MYPi", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

