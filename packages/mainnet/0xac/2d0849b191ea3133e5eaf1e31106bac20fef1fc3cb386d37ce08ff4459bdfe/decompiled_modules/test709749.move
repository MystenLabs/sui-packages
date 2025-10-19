module 0xac2d0849b191ea3133e5eaf1e31106bac20fef1fc3cb386d37ce08ff4459bdfe::test709749 {
    struct TEST709749 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST709749, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST709749>(arg0, 9, b"TEST709749", b"Test Token 709749", b"Token for testing complete lifecycle", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST709749>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST709749>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

