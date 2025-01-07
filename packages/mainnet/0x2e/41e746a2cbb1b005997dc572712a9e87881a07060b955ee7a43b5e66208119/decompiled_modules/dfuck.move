module 0x2e41e746a2cbb1b005997dc572712a9e87881a07060b955ee7a43b5e66208119::dfuck {
    struct DFUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFUCK>(arg0, 6, b"DFUCK", b"DFUCK ON SUI", b"DUCK FUCK HOP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730988265988.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

