module 0x6d972f345b698ada52a7d40444d38fba13a17365bdb177967c6cc1a60e581a12::sui4 {
    struct SUI4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI4>(arg0, 6, b"SUI4", b"SUI 4 DOLLARS", b"SUI HIT 4 DOLLARS. CLICK THE X, SUPPORT SUI, AND LETS KEEP GROWING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_0afe1664e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI4>>(v1);
    }

    // decompiled from Move bytecode v6
}

