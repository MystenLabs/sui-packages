module 0xc44333b37e91c73883197b297d0fb2025d17d25c29a1be6d1994fa143426d2d0::sass {
    struct SASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASS>(arg0, 6, b"SASS", b"SUIASS", b"SUIASS IS AL ABOUT WOMENS ASS ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e256a9a9b1caf0b2a2628cebc90a0ac3_61ecb5fdff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

