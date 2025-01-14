module 0x8da87c2e4b0c072b12bba1b2a937ed7b920f92e0f46ba8256352c2da4cf2c21e::angeltrump {
    struct ANGELTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGELTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGELTRUMP>(arg0, 6, b"AngelTrump", b"Angel Trump", b"Cute Little Angel Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736828011351.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANGELTRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGELTRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

