module 0xb7028001cbf877232c99ee92fdb21027b377e095320e3fe5966c5ee52bbdc8f0::trmp {
    struct TRMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TRMP>(arg0, 13748216442875772226, b"TRUMP OFFICALL", b"TRMP", b"NEW WORD", b"https://images.hop.ag/ipfs/QmbSesn247RtTRSJ2d6KzbDztZaAgYusGgAsB2HpgDK673", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

