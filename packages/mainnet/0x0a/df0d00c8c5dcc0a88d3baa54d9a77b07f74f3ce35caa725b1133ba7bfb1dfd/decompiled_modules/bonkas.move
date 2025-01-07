module 0xadf0d00c8c5dcc0a88d3baa54d9a77b07f74f3ce35caa725b1133ba7bfb1dfd::bonkas {
    struct BONKAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKAS>(arg0, 6, b"BONKAS", b"Bonk of America on Sui", b"$BONKAS ON SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_02_17_02_20_32_5a50988ff6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

