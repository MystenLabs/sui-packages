module 0xd012af8f71524c1bb1dd2d007c57e0503927f4a0af65ca1cf5658a58c46477f8::dart {
    struct DART has drop {
        dummy_field: bool,
    }

    fun init(arg0: DART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DART>(arg0, 6, b"DART", b"DART COIN", b"DART COIN DART", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731654240837.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DART>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DART>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

