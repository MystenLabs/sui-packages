module 0x47aa9d68f8f473b368f727a3135fcd3d2a0501e1d2e5f9b4863373364a098bdf::beng {
    struct BENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENG>(arg0, 6, b"BENG", b"NOT BUY !!!!!!", b"NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!NOT BUY !!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B_fa3d9364c9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

