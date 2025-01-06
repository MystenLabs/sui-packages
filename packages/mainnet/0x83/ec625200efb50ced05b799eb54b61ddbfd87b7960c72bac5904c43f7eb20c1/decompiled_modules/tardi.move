module 0x83ec625200efb50ced05b799eb54b61ddbfd87b7960c72bac5904c43f7eb20c1::tardi {
    struct TARDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARDI>(arg0, 6, b"TARDI", b"Tardi the water bear", b"Hi, I'm Tardi :) Unbreakable by design! Elon sent me to the moon, but now its time we go interplanetary", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_06_13_08_24_e3b0adc290.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TARDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

