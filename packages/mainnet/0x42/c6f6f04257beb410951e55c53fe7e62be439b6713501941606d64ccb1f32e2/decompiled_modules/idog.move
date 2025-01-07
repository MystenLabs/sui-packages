module 0x42c6f6f04257beb410951e55c53fe7e62be439b6713501941606d64ccb1f32e2::idog {
    struct IDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDOG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<IDOG>(arg0, 9053619460727237025, b"Iron Doge", b"IDOG", b"Iron Doge", b"https://images.hop.ag/ipfs/QmegQaFNktE3c4KoDzJ1FwUNUZczvBvMMvHpSeHNNP5bpA", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

