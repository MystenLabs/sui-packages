module 0x75d6f2d51938f614f68c36b5a13665bb6c5c17f0b3f46f246cd0b723652ce07d::skanyew {
    struct SKANYEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKANYEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKANYEW>(arg0, 6, b"SKANYEW", b"SuiKanyeW", b"The Kanye West Sui Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kawaii_Chibi_Kanye_West_54904158_1_3b2665cbad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKANYEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKANYEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

