module 0x547c47ed836d926e39b87c0e42b5a0dd1a0b04c0860f650b41348296da6990cc::tmeg {
    struct TMEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMEG>(arg0, 6, b"TMEG", b"The meg", b"The king is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5838_ff4d2dea03.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TMEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

