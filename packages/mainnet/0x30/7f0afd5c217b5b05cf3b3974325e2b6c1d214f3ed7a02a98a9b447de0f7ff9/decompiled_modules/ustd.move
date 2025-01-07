module 0x307f0afd5c217b5b05cf3b3974325e2b6c1d214f3ed7a02a98a9b447de0f7ff9::ustd {
    struct USTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USTD>(arg0, 6, b"USTD", b"USTAD KIRITO", b"Wallahi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949958143.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USTD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USTD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

