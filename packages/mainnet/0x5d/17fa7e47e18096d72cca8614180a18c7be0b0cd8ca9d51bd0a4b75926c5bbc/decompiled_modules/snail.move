module 0x5d17fa7e47e18096d72cca8614180a18c7be0b0cd8ca9d51bd0a4b75926c5bbc::snail {
    struct SNAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAIL>(arg0, 6, b"Snail", b"Snail On Sui", b"Just Snail", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1743876562493.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNAIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

