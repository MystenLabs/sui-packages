module 0xc821ec641dd5654e4c091e868c169097bf3a5ded8b1812fab02d25ffe3c6528f::suiikawa {
    struct SUIIKAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIKAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIKAWA>(arg0, 6, b"SUIIKAWA", b"suiikawa", b"KAWAII CREATURE IN JAPAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1406_e3f78c9d7d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIKAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIKAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

