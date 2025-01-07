module 0xe78956a1edcec962d7a17beda2bccf3f265afc0c8d73a283ca1d522d759a964b::suibo {
    struct SUIBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBO>(arg0, 6, b"SUIBO", b"Suibo", b"BOBO on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_23_16_47_946f502a2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

