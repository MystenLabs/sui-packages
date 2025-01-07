module 0xd4c7895d915e89e0bfd827d30c15525a3646ef19958e30759ce974576b137b6f::mouse {
    struct MOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MOUSE>(arg0, 5775437466327035402, b"Trench mouse", b"Mouse", b"In the trenches of sui since the beginning. Weary but has never wavered. Emerging in the bull for the first time", b"https://images.hop.ag/ipfs/QmS2Jir7NAJAh15YRw9Z8gHDqRQBhWT2F5WNLq362qwLYg", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

