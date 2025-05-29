module 0xc0275138ce0b0f4851e0aaabfe224fd48562ee9f790471dacb25be204a81f628::jesus {
    struct JESUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUS>(arg0, 6, b"JESUS", b"JESUScoin", b"Jesus coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7279_2a912648d2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

