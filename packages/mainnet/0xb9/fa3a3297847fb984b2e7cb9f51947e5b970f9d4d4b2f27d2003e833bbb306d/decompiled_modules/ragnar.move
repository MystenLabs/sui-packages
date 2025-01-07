module 0xb9fa3a3297847fb984b2e7cb9f51947e5b970f9d4d4b2f27d2003e833bbb306d::ragnar {
    struct RAGNAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAGNAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAGNAR>(arg0, 6, b"Ragnar", b"RagnarCatSui", b"A weed addict cat coming to sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731767810763.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAGNAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAGNAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

