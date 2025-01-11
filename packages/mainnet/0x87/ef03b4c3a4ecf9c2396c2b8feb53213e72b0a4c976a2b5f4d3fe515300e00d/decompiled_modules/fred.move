module 0x87ef03b4c3a4ecf9c2396c2b8feb53213e72b0a4c976a2b5f4d3fe515300e00d::fred {
    struct FRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRED>(arg0, 6, b"FRED", b"Fred", b"groundbreaking memecoin on the Sui blockchain, designed to build a strong, active, and engaged community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250111_224926_c156bda5d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRED>>(v1);
    }

    // decompiled from Move bytecode v6
}

