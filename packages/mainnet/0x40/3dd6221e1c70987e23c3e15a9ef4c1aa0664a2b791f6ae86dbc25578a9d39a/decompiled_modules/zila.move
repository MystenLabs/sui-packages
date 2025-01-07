module 0x403dd6221e1c70987e23c3e15a9ef4c1aa0664a2b791f6ae86dbc25578a9d39a::zila {
    struct ZILA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZILA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZILA>(arg0, 6, b"Zila", b"Zila Sui", x"4865206d6f7374206d656d6561626c65206d656d65636f696e20696e206578697374656e63652e2054686520426c7562206861766520686164207468656972206461792c206974732074696d6520666f72205a696c6120746f2074616b6520726569676e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_30_21_19_09_ab5db7880b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZILA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZILA>>(v1);
    }

    // decompiled from Move bytecode v6
}

