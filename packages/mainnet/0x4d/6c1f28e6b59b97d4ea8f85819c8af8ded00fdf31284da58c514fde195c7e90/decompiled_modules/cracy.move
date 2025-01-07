module 0x4d6c1f28e6b59b97d4ea8f85819c8af8ded00fdf31284da58c514fde195c7e90::cracy {
    struct CRACY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRACY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRACY>(arg0, 6, b"Cracy", b"Craby Sui", b"Craby has arrived to Sui created by Matt Furie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Remove_bg_ai_1727459144166_4aa1076e70.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRACY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRACY>>(v1);
    }

    // decompiled from Move bytecode v6
}

