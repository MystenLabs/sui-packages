module 0xac509aaa9b9285062fa49014948e816fd84c76439af6f26c619e7206e79cec76::pdog {
    struct PDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDOG>(arg0, 6, b"Pdog", b"PoochDog ", b"Just an ai dog named PoochDog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731966264379.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

