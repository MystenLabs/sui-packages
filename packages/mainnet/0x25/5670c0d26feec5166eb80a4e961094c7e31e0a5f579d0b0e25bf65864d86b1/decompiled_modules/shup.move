module 0x255670c0d26feec5166eb80a4e961094c7e31e0a5f579d0b0e25bf65864d86b1::shup {
    struct SHUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUP>(arg0, 6, b"SHUP", b"Shut Up", b"Shup Up on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052089_20d59c48f2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

