module 0x31a4ff3262ad617f3bbe8c457abee115dc0c750023ae176fa87184cf0246f82b::vioai {
    struct VIOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIOAI>(arg0, 6, b"VioAI", b"Vio AI", b"A lovely girl on crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2141_c1e96cabcd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIOAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIOAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

