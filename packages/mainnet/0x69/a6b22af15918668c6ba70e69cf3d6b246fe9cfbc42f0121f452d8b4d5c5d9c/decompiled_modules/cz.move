module 0x69a6b22af15918668c6ba70e69cf3d6b246fe9cfbc42f0121f452d8b4d5c5d9c::cz {
    struct CZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CZ>(arg0, 6, b"CZ", b"CZ AI", x"435a20414920776173206372656174656420627920746865205375694149207465616d20746f2073686f776361736520686f772074686520706c6174666f726d20776f726b732e204974e2809973207375706572206561737920746f207573652c20616e642074686973206167656e742069732061206c6f74206f662066756e2e20456e6a6f7921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/CZ_5_e76412ee7b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

