module 0xd065bb28ddc86e0296cd596d7c7b58647b695ec59c46251ad8d538b8212c228d::boys {
    struct BOYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOYS>(arg0, 6, b"BOYS", b"Baby Boys Club", b"Welcome to the world of Baby Boys, the latest meme coin sensation!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_boyclub_57fee6b695.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

