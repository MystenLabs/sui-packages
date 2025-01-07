module 0x11b44b9a2bf73e11afd86cbb6923cb60e568d06468b9220349bed9e7d795c7a4::chillmoodeng {
    struct CHILLMOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLMOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLMOODENG>(arg0, 6, b"CHILLMOODENG", b"Just Chill Moo Deng", x"4368696c6c204d6f6f2044656e6720697320612072656c6178656420686970706f2077686f2066696e6473206a6f7920696e2073756e62617468696e6720616e64206e617070696e6720706561636566756c6c792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CHILL_MOODENG_02_2f96078e81.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLMOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLMOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

