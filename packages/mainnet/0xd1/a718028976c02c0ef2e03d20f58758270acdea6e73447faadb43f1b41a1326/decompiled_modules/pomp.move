module 0xd1a718028976c02c0ef2e03d20f58758270acdea6e73447faadb43f1b41a1326::pomp {
    struct POMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POMP>(arg0, 6, b"POMP", b"Pomp", b"POMP is the first ever TAP2Earn game on SUI Chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_03_18_06_53_0eada46ea5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

