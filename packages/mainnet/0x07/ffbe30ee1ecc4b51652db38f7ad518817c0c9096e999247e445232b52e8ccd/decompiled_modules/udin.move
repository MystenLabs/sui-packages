module 0x7ffbe30ee1ecc4b51652db38f7ad518817c0c9096e999247e445232b52e8ccd::udin {
    struct UDIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UDIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<UDIN>(arg0, 9007669371905855573, b"PEJUANG SEMUT", b"udin", b"asdsad", b"https://images.hop.ag/ipfs/QmUknGMCnzTs9LVGnHHqwAxXf9YRZ3NvXswACQNbpbJSZr", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

