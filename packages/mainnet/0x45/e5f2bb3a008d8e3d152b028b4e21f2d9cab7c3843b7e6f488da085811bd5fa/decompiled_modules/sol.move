module 0x45e5f2bb3a008d8e3d152b028b4e21f2d9cab7c3843b7e6f488da085811bd5fa::sol {
    struct SOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SOL>(arg0, 1525125887301631763, b"Menendez Brothers", b"Sol", b"When you do the crime you do the time .Federal inmates 2nd chance everyone deserves that opportunity to show and prove judgement free zone", b"https://images.hop.ag/ipfs/QmSXMTQZmTKSPEJTNTyeQnxAUMzAEbi71hYvU7carZ8Sh1", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

