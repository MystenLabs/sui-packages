module 0x5615090767e3b3860a7c5f8ad27ad30f45c350b136f0a7ca5579cdaf0f99ffd9::bapeanut {
    struct BAPEANUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAPEANUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAPEANUT>(arg0, 6, b"BAPEANUT", b"Banana Peanut", b"Banana Peanut on sui chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731946832658.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAPEANUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAPEANUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

