module 0xf500e674f6cef06c8484ae53ef476fd8f37c55b6338a42d9be4dbb5c22f236c6::tttas {
    struct TTTAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTTAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTTAS>(arg0, 6, b"TTTAS", b"TTAAAAA", b"AAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750720982366.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTTAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTTAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

