module 0xd6ca489eae1b866aae024d157b7706f642bf1f458d2e0fbbe5b2adb8a355a6bc::trunk {
    struct TRUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUNK>(arg0, 6, b"Trunk", b"Elephant Money", b"ELEPHANT.MONEY is the first global decentralized community bank of its kind. It is a permissionless system that accumulates wealth through stable coin backed deflationary assets and yield.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4839_4c49166360.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

