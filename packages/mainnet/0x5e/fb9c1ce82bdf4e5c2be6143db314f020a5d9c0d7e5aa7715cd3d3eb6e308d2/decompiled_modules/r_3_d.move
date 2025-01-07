module 0x5efb9c1ce82bdf4e5c2be6143db314f020a5d9c0d7e5aa7715cd3d3eb6e308d2::r_3_d {
    struct R_3_D has drop {
        dummy_field: bool,
    }

    fun init(arg0: R_3_D, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<R_3_D>(arg0, 11548641523633976640, x"523364e280a2c3987262", b"R3d", x"c3866e69676dc3a62e", b"https://images.hop.ag/ipfs/QmS2g2WtvFTik1vmbuxhNk9DNnnD7aX9oLPHNmjXmqUfYR", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

