module 0x36de4314320b2e0500f1652535fb9829019abdb529e0b057eb6128fab93cbc91::suiva {
    struct SUIVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVA>(arg0, 6, b"SUIVA", b"SHIVA", b"Suiva, also known as Mahadeva, is one of the main deities of Hinduism.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiva_519e40a3a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

