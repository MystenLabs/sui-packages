module 0x855cae156b2bf72ee433ab50df2dc8df27ae429407fc5320df30062d3903caa3::bouncycat {
    struct BOUNCYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOUNCYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BOUNCYCAT>(arg0, 17970699062068130551, b"Bouncy Cat", b"BouncyCat", b"The cat bounce", b"https://images.hop.ag/ipfs/QmXfa56jFMAQ42LmfbbqXAgbiYW6P8DHLHDF5kt98ZGy1g", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

