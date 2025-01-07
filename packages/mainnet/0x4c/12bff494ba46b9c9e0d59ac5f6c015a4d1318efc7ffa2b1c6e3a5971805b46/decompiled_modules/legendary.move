module 0x4c12bff494ba46b9c9e0d59ac5f6c015a4d1318efc7ffa2b1c6e3a5971805b46::legendary {
    struct LEGENDARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGENDARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGENDARY>(arg0, 6, b"LEGENDARY", b"LEGENDARY REVENGE ARC", b"LEGENDARY REVENGE ARC. MAKE IT ALL BACK WITH ONE TRADE! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5438_73b61e1131.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGENDARY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEGENDARY>>(v1);
    }

    // decompiled from Move bytecode v6
}

