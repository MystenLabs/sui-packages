module 0xb8a086d515c7dd99732d7c5f817a7564da65e2920014a9835d940f8c4e14fd25::kiro {
    struct KIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRO>(arg0, 6, b"KIRO", b"King Ronaldo", b"king of football", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000059783_e1d1c6654c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

