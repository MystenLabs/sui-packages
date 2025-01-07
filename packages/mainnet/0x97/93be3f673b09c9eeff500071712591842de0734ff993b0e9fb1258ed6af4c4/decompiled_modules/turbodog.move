module 0x9793be3f673b09c9eeff500071712591842de0734ff993b0e9fb1258ed6af4c4::turbodog {
    struct TURBODOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBODOG>(arg0, 6, b"Turbodog", b"TURBODOG", b"FASTEST DOG ON SUI. We running to the top! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953284870.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBODOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBODOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

