module 0xc64ec6d9cbf5ae7eb3abba4c9b0ce20e18c98c52f96a22dc5787870ebb8b7613::tape {
    struct TAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAPE>(arg0, 6, b"Tape", b"tappezino", b"RYPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/whitepaper_bddae00ae9.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

