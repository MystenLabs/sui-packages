module 0x842de0b73ca40bc05f1cb0239f31105dfaee1ac1d068281f849bb865e1e88f2d::froge {
    struct FROGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGE>(arg0, 6, b"FROGE", b"Crazy Froge", b"Crazy Froge on SUI: Hopping into the blockchain with wild energy and unstoppable leaps!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_30_21_19_37_ed0294fd52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

