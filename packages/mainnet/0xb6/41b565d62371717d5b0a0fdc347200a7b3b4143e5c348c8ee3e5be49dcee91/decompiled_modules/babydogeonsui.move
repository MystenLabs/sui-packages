module 0xb641b565d62371717d5b0a0fdc347200a7b3b4143e5c348c8ee3e5be49dcee91::babydogeonsui {
    struct BABYDOGEONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYDOGEONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYDOGEONSUI>(arg0, 6, b"BABYDOGEONSUI", b"BABYDOGE", b"Posted by Babydoge.sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5847_1283d54df7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYDOGEONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYDOGEONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

