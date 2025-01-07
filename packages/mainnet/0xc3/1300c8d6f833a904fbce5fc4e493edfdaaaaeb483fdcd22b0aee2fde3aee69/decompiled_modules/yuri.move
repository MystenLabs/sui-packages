module 0xc31300c8d6f833a904fbce5fc4e493edfdaaaaeb483fdcd22b0aee2fde3aee69::yuri {
    struct YURI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YURI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YURI>(arg0, 6, b"YURI", b"Lesbian Yuri", b"First LESBIAN NSFW ON TURBO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953881561.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YURI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YURI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

