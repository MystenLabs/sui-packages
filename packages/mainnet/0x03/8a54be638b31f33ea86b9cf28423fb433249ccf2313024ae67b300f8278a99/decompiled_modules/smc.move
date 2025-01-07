module 0x38a54be638b31f33ea86b9cf28423fb433249ccf2313024ae67b300f8278a99::smc {
    struct SMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMC>(arg0, 6, b"Smc", b"Suiperman coin", x"5375697065726d616e2063616ee28099742062652073746f707065642e204e6f74206576656e206279204b727970746f6e6974652e20546f20746865206d6f6f6e20616e64206265796f6e6420f09f9a80f09f8c95f09f8c9ff09faa90", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734313337339.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

