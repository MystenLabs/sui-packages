module 0x1f3e5d8f52a1404d5f3077b60b763b0c5087f946f6dafb5096d67c53f2bc657::dr1am1 {
    struct DR1AM1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DR1AM1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DR1AM1>(arg0, 8, b"DR1AM1", b"DR1AM1", b"this is dr1am1coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DR1AM1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DR1AM1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

