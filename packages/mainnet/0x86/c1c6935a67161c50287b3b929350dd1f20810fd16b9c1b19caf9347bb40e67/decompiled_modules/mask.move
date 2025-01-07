module 0x86c1c6935a67161c50287b3b929350dd1f20810fd16b9c1b19caf9347bb40e67::mask {
    struct MASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MASK>(arg0, 17541734086637588927, b"Mask", b"Mask", b"Mask movie Meme coin", b"https://images.hop.ag/ipfs/QmYFpE97rgQGhHK3B4sdpa3XYBschbHwKweQDHnbB77YNm", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

