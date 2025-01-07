module 0x158cd1f90f429d9bfdcca93f1b6ffb1c4fc64ab76cfd9d7d8ca2018e54b5d230::aaaapufff {
    struct AAAAPUFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAPUFFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAPUFFF>(arg0, 6, b"Aaaapufff", b"apuff", b"aaaaapuff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaapuff_0d2de74956.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAPUFFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAPUFFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

