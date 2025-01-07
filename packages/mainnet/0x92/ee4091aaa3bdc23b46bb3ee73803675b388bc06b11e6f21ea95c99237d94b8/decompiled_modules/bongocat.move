module 0x92ee4091aaa3bdc23b46bb3ee73803675b388bc06b11e6f21ea95c99237d94b8::bongocat {
    struct BONGOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONGOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONGOCAT>(arg0, 6, b"BONGOCAT", b"BONGO CAT ON SUI", b"Hit the SUI likeBongo Cat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_05_17_57_e650fa5ba8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONGOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONGOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

