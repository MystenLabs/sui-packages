module 0x7d8a440dee59f0063ecfd802c2ebd7c58093a656f760be49d188588f9c0d2dcc::suilong {
    struct SUILONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILONG>(arg0, 6, b"SUILONG", b"SUI LONG", b"SUI LONG - First LONG on SUI chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_03_29_09_52_13_81a50f0d21.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

