module 0xbe77bb514523f118e45263851def5b55d6ad454d27bc6b3dda964342412cc36c::summerparty {
    struct SUMMERPARTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMMERPARTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMMERPARTY>(arg0, 6, b"SUMMERPARTY", b"BLUE MEME SUMMER", b"WHERE MEME MEET BLUE AND FRENSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3653_d93f92c906.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMMERPARTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMMERPARTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

