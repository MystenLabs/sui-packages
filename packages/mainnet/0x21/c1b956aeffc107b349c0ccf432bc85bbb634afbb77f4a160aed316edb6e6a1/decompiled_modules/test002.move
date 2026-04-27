module 0x21c1b956aeffc107b349c0ccf432bc85bbb634afbb77f4a160aed316edb6e6a1::test002 {
    struct TEST002 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST002, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://images.unsplash.com/photo-1493612276216-ee3925520721";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<TEST002>(arg0, 9, b"TEST002", b"Test DSU Token", b"Description for DSU 27.04.2026 TOKEN.", v1, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST002>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST002>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

