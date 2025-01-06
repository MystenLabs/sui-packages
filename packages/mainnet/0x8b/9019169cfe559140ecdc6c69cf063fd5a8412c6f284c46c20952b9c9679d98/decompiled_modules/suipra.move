module 0x8b9019169cfe559140ecdc6c69cf063fd5a8412c6f284c46c20952b9c9679d98::suipra {
    struct SUIPRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPRA>(arg0, 6, b"SUIPRA", b"Is That A SUIpra?", x"42726f2e2e2049732054686174206120535549505241413f3f21210a5965732069747320746865204661737465722076657273696f6e206f6620746865206f726967696e616c20776974682031303030303048702069742063616e20676f20746f20746865206d6f6f6e20616e64206261636b20696e206d696e75746573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGA_342_2dd541fde1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

