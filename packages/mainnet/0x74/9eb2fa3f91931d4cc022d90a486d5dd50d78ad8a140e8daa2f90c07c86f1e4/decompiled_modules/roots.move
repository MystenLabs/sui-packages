module 0x749eb2fa3f91931d4cc022d90a486d5dd50d78ad8a140e8daa2f90c07c86f1e4::roots {
    struct ROOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOTS>(arg0, 6, b"ROOTS", b"LETS ROOT", b"Cute creatures have come from the Suiverse to colonize Earth! Get ready, lets rt!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ROOT_6b7d819abd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

