module 0x387ca47ab015c747383941aa524dab63f61d63e2130affe7825c1b834c9f829d::rebelcoin {
    struct REBELCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: REBELCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REBELCOIN>(arg0, 6, b"RebelCoin", b"RebelCoin on sui", b"Welcome a sophisticated investor to RebelCoin! We look forward to discussing the latest market trends with you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_26_16_03_30_b679f7d157.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REBELCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REBELCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

