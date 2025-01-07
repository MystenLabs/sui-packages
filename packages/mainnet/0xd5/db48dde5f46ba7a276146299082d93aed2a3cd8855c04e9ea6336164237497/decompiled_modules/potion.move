module 0xd5db48dde5f46ba7a276146299082d93aed2a3cd8855c04e9ea6336164237497::potion {
    struct POTION has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTION>(arg0, 6, b"POTION", b"Sui Potion", x"42726577656420746f2070657266656374696f6e2c2024504f54494f4e206272696e6773206d6167696320616e64206d79737465727920746f2074686520537569204e6574776f726b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_25_866c641a66.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POTION>>(v1);
    }

    // decompiled from Move bytecode v6
}

