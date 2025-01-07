module 0x97e8df9b70768c5b1475e9add63f5d0806f811f044ed6d34fb038f485a92583e::sewey {
    struct SEWEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEWEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEWEY>(arg0, 6, b"SEWEY", b"SEWEYcide squad", b"No tg no Twitter just pure vibe on the SEWEY blockchain technology", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5292_c001fe52cc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEWEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEWEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

