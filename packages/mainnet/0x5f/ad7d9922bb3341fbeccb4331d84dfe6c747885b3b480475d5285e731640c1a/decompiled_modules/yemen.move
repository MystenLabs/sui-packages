module 0x5fad7d9922bb3341fbeccb4331d84dfe6c747885b3b480475d5285e731640c1a::yemen {
    struct YEMEN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YEMEN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x9cf4af82d196b11bdaeace419958508088b609c4c9aa5d56796ae58672f6ccb9, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<YEMEN>>(0x2::coin::mint<YEMEN>(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: YEMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YEMEN>(arg0, 9, b"YEMEN", b"Yemen", b"Strive for Peace. Prepare for War.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/9039HP7f/bafkreicgh3syea6bk54y7y2qiwvfzdi3rqgsbnj3m3gl7cg7fa7lknk5u4.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YEMEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YEMEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

