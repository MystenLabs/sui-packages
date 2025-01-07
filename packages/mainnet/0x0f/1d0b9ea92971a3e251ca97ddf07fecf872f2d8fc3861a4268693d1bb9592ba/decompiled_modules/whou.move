module 0xf1d0b9ea92971a3e251ca97ddf07fecf872f2d8fc3861a4268693d1bb9592ba::whou {
    struct WHOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHOU>(arg0, 6, b"WHOU", b"who r u ?", b"who r u bro ??", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731251626496.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHOU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHOU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

