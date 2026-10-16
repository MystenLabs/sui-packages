module 0x2fb0ede53d19d1ee486195d390581509aa1393abf4f0552c9c1ca50fd1f6a1c8::bbb {
    struct BBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBB>(arg0, 6, b"BBB", b"aaaa", b"aaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1792132211165.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

