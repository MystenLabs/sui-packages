module 0xdbda0d76c9dc18881dda81d4065a5e1bf6fd8dbc81de28393c68ff073f8a5216::dollarcoin {
    struct DOLLARCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLLARCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLARCOIN>(arg0, 6, b"DOLLARCOIN", b"will go to $1", b"will go to $1 (DOLLARCOIN)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fxk8kft224ghuhmp0swlhmsxrl4k_1f3b167144.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLARCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLLARCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

