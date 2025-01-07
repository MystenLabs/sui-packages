module 0xc970a8cbb97fead2bc53c52c02d57c236c150a996db80e2292ff2e9eaa965345::fruits {
    struct FRUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRUITS>(arg0, 6, b"FRUITS", b"Fruits on Sui", b"Buy $fruits to make your body healthy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/favicon3_fea66ac378.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRUITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRUITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

