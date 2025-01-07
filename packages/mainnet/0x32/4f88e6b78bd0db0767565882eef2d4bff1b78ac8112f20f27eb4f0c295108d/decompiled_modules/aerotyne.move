module 0x324f88e6b78bd0db0767565882eef2d4bff1b78ac8112f20f27eb4f0c295108d::aerotyne {
    struct AEROTYNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AEROTYNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AEROTYNE>(arg0, 6, b"AEROTYNE", b"AEROTYNE INTERNATIONAL", b"A cutting edge high-tech firm out of the Midwest awaiting imminent patent approval on the next generation of radar detectors that have both huge military and civilian applications now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11111_72d36b387c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEROTYNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AEROTYNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

