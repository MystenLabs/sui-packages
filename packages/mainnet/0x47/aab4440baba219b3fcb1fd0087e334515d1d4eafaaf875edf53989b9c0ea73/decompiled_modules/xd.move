module 0x47aab4440baba219b3fcb1fd0087e334515d1d4eafaaf875edf53989b9c0ea73::xd {
    struct XD has drop {
        dummy_field: bool,
    }

    fun init(arg0: XD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XD>(arg0, 6, b"XD", b"X Doge", b"Meme is the best opportunity ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000743487_0fdccf34f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XD>>(v1);
    }

    // decompiled from Move bytecode v6
}

