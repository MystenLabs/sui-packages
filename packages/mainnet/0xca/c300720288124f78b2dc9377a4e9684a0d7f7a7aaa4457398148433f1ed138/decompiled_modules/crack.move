module 0xcac300720288124f78b2dc9377a4e9684a0d7f7a7aaa4457398148433f1ed138::crack {
    struct CRACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRACK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<CRACK>(arg0, 18119471625832489838, b"Crack Fox", b"CRACK", x"4576657279207468696e677320646966666572656e7420696e206d7920776f726c642068612068756820f09fa68a", b"https://images.hop.ag/ipfs/QmVBRA3sH2dnUN72PnUqMEoEQCSpHJ25mL3ogAh2dTmJj1", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

