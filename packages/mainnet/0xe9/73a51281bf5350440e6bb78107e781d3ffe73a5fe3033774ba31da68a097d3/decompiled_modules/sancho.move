module 0xe973a51281bf5350440e6bb78107e781d3ffe73a5fe3033774ba31da68a097d3::sancho {
    struct SANCHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANCHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANCHO>(arg0, 6, b"SANCHO", b"Sancho on Sui", b"Sancho's Boys Club is redefining the intersection of memes and culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1d4f3b042f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANCHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANCHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

