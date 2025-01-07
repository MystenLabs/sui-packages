module 0xa3cffa35344ea4dc1dedcae09ff6db470a3c740713ac4e4f74701a7d6c7a83f3::epoch {
    struct EPOCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPOCH, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<EPOCH>(arg0, 13070871209817593058, b"EPOCH", b"EPOCH", b"Remember? If yes - then buy!", b"https://images.hop.ag/ipfs/QmRURaaNbiCp9XXYYYqfBgRHyQfLJKG4B94xWtz7VQLtLw", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

