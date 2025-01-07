module 0xee14325d63baed01476a1b78909ea18ed01568083de82f8800be37ea8a231e61::yyeess {
    struct YYEESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YYEESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YYEESS>(arg0, 6, b"YYEESS", b"YES", b"YES OFC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MP_Ak_Rjj_400x400_a00a6409ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YYEESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YYEESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

