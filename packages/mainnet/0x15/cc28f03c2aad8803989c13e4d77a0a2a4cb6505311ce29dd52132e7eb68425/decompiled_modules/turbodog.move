module 0x15cc28f03c2aad8803989c13e4d77a0a2a4cb6505311ce29dd52132e7eb68425::turbodog {
    struct TURBODOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBODOG>(arg0, 6, b"Turbodog", b"TurbodogonSUI", b"Turbodog on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730990517212.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBODOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBODOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

