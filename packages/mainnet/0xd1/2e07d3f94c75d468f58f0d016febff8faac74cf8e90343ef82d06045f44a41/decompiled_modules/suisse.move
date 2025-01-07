module 0xd12e07d3f94c75d468f58f0d016febff8faac74cf8e90343ef82d06045f44a41::suisse {
    struct SUISSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISSE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUISSE>(arg0, 8628372669424219745, b"Sui Silver", b"$SUISSE", b"PAMP $Suisse 1 KILO FINE SILVER", b"https://images.hop.ag/ipfs/QmPrt7vEGXbU1SAU4EWbvK5h1bd6FhtcwC1Xi4CUHhrBwJ", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

