module 0x3948f7663dc5ab2e84210dffd6263099100ae8e0e3a8dfc504c1b98343464cdd::fsog {
    struct FSOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSOG>(arg0, 6, b"FSOG", b"French Seal Dog", b"Im a Seal Dog but French. Bonjourawr! Send it! Boost it! Socials reveal after king of the sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DE_9609_FC_4_BA_4_4195_9_D05_29_E6_FCEDD_88_E_274a60aa7c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

