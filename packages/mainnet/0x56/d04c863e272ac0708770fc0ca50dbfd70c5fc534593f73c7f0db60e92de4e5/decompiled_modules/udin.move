module 0x56d04c863e272ac0708770fc0ca50dbfd70c5fc534593f73c7f0db60e92de4e5::udin {
    struct UDIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UDIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<UDIN>(arg0, 18004759968035901555, b"Pejuang Semut", b"UDIN", b"asdasd", b"https://images.hop.ag/ipfs/QmW6G5aUrk179SXKXFLNBgCNH92uifYCCgjyo2eLiZwsom", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

