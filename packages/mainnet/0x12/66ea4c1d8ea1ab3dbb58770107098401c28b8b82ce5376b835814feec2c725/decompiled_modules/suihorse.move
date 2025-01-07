module 0x1266ea4c1d8ea1ab3dbb58770107098401c28b8b82ce5376b835814feec2c725::suihorse {
    struct SUIHORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHORSE>(arg0, 6, b"SUIHORSE", b"Suihorse the Seahorse", b"Suihorse, the magical seahorse of Sui. Leading traders to success within the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aa_cc84bcdc24.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHORSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHORSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

