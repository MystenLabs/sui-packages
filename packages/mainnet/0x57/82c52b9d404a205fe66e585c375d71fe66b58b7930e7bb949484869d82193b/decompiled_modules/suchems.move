module 0x5782c52b9d404a205fe66e585c375d71fe66b58b7930e7bb949484869d82193b::suchems {
    struct SUCHEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCHEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCHEMS>(arg0, 6, b"SUCHEMS", b"Cheeems", b"SUCHEMSSUCHEMSSUCHEMSSUCHEMSSUCHEMS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_09_57_01_b41aa2986f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCHEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCHEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

