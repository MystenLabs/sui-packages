module 0xcb48e09f1f2a1e887155bba48fb1222c1f2ca80c8e0aa2bf1eabb1a1dbaf86c5::meth {
    struct METH has drop {
        dummy_field: bool,
    }

    fun init(arg0: METH, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<METH>(arg0, 15201540147636700466, b"N-methyl-1-phenylpropan-2-amine", b"METH", b"Fastest meth on chain", b"https://images.hop.ag/ipfs/QmcoNgshGrU6DW3BPa9UBq4m2MiHjcbkHStQ2LXrD4Pxke", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

