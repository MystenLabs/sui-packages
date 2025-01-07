module 0x9ea762383e8b2b2da32214aa997fe70688358ce4d3f07f19a98b330c8db05471::nigasfortrump {
    struct NIGASFORTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGASFORTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<NIGASFORTRUMP>(arg0, 17885975762909350665, b"NIGAS FOR TRUMP", b"NIGASFORTRUMP", b"THE HOLDERS GET N-WORD PASS", b"https://images.hop.ag/ipfs/QmXBJoL4WX8enMrKS5ZpvFLebbkvJPK5NMbEhfAvkXK7L8", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

