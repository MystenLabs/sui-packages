module 0x8e0ba7a1facf96b8e90e6dac7eb3d3735c6b073b9405518d4b760b72e361b056::omnicat {
    struct OMNICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMNICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMNICAT>(arg0, 6, b"Omnicat", b"Omni", b"Omni cat on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029383_1b61e4f94f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMNICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMNICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

