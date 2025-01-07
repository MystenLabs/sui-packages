module 0x75a1334ab7c335dd9305b0c4a555051b6acac809662c53d859570660a6d4bbd4::chillkdot {
    struct CHILLKDOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLKDOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLKDOT>(arg0, 6, b"ChillKDot", b"Chill KDot", b"KDot is Just Chilln! Leave him alone before he turns you into a song!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chill_K_Dot_5c9066e9f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLKDOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLKDOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

