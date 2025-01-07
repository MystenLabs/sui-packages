module 0x3d5c654394d2da8690627968e7d6fcf7d6a07d0a75a4b423769f964e712860b3::pingu {
    struct PINGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINGU>(arg0, 6, b"PINGU", b"Pingu", b"Richest Bird On SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pingu_prof_6206aab2e2.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

