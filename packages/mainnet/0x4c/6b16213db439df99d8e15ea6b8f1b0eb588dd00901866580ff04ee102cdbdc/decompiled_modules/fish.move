module 0x4c6b16213db439df99d8e15ea6b8f1b0eb588dd00901866580ff04ee102cdbdc::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<FISH>(arg0, 11561912574105567079, b"fish man", b"fish", b"fish man coin", b"https://images.hop.ag/ipfs/QmXTLQEy2AcwYTZDkKpxu6qasqUww9iFykTfEESstuwDmn", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

