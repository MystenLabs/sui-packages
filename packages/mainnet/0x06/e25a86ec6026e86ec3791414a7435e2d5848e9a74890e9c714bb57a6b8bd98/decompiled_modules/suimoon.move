module 0x6e25a86ec6026e86ec3791414a7435e2d5848e9a74890e9c714bb57a6b8bd98::suimoon {
    struct SUIMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOON>(arg0, 6, b"SuiMoon", b"Suilor Moon", x"20546865206d61676963616c206d656d65636f696e20696e737069726564206279205361696c6f72204d6f6f6e0a204c61756e636820536f6f6e207c20426577617265206f66205363616d73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_03_00_26_27_4c5a2f7cf1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

