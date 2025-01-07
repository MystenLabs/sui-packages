module 0xb13bca4a4ea52204b1b55027d02e17b48d7348f69744700c28c6ac72413ce862::bulpen {
    struct BULPEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULPEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULPEN>(arg0, 6, b"BULPEN", b"Bulldog Penguin", b"Ohtanis biggest nightmare", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1088_5097861175.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULPEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULPEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

