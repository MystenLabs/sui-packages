module 0x647792dca1788cd453b873c984abe7b813397c4d27708ed004697839d43749b6::reef {
    struct REEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: REEF, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<REEF>(arg0, 16814795590625451867, b"Reef COIN", b"reef", b"reef coin game", b"https://images.hop.ag/ipfs/QmYuY1cu99LjzkhnHVs1USAjyxtLymTUXju948du3XiZts", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

