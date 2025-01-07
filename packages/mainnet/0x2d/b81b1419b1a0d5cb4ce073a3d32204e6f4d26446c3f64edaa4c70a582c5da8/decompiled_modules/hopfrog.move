module 0x2db81b1419b1a0d5cb4ce073a3d32204e6f4d26446c3f64edaa4c70a582c5da8::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 2581778273379553330, b"HopFrog", b"HopFrog", b"First Frog on Hop Fun", b"https://images.hop.ag/ipfs/QmdvBkbyMQYnUEqpdFuhvFDPbHVfqGUBvSEbN6MTZBHvxT", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

