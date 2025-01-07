module 0xcae65a36cbc5800e368d84713c51db336e0011cb8dd59a13c59cd7fa28983a0a::hoppo {
    struct HOPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPPO>(arg0, 16371589483552429833, b"HOPPO", b"HOPPO", b"HOPPO", b"https://images.hop.ag/ipfs/QmQqjFXYoRKkL1QNCiBeYDXMLceVGRQdm2oJtd1y58GWAu", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

