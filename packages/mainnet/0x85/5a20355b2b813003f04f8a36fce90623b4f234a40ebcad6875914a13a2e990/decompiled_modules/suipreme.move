module 0x855a20355b2b813003f04f8a36fce90623b4f234a40ebcad6875914a13a2e990::suipreme {
    struct SUIPREME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPREME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPREME>(arg0, 6, b"SUIPREME", b"Suipreme", b"SUI's culture coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_621d3d1bc4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPREME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPREME>>(v1);
    }

    // decompiled from Move bytecode v6
}

