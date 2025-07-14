module 0x4f79908040822a25ab54be29698ec5eaf8f0b2fe5267e5b6d476113f2db904a0::chillguy {
    struct CHILLGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHILLGUY>(arg0, 6, b"CHILLGUY", b"Just a chill guy", b"Just a chill guy !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Chill_guy_original_artwork_d6b549a2c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHILLGUY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLGUY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

