module 0xfd29e14646f263505fe90ce2cacd3b189a2b82a413f98f003dad71317af8a3::agld_flying {
    struct AGLD_FLYING has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGLD_FLYING, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<AGLD_FLYING>(arg0, 1189122177760199171, b"AGLD", b"AGLD Flying", b"AGLD Devnet To Mainet", b"https://images.hop.ag/ipfs/QmdoKQF5kDHW6y2HjFGYZcgTxEYW3aHKoVhyp6tmVAmPn3", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

