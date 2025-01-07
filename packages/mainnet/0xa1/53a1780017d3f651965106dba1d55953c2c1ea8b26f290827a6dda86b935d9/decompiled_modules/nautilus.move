module 0xa153a1780017d3f651965106dba1d55953c2c1ea8b26f290827a6dda86b935d9::nautilus {
    struct NAUTILUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAUTILUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAUTILUS>(arg0, 6, b"Nautilus", b"the Titan of the Depths", x"42657761726520746865206465707468732e0a416c6c2077696c6c2064726f776e2e0a466f72776172642c20666f72776172642e0a4c65667420746f206469652e0a5065657220696e746f20746865206461726b6e6573732e0a54686520656e646c657373206d617263682e0a49276d20204e617574696c757321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241218_124912_98bcd0fabf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAUTILUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAUTILUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

