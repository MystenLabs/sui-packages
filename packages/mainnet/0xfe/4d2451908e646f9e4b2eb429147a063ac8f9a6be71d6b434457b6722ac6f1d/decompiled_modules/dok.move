module 0xfe4d2451908e646f9e4b2eb429147a063ac8f9a6be71d6b434457b6722ac6f1d::dok {
    struct DOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOK>(arg0, 9, b"DOK", b"DOKEN", b"give me my money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/b0920a50-0e0d-11f0-8d6d-c97d944baca4")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOK>>(v1);
        0x2::coin::mint_and_transfer<DOK>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOK>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

