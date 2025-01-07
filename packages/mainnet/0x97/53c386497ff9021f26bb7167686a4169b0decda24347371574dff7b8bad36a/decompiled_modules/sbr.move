module 0x9753c386497ff9021f26bb7167686a4169b0decda24347371574dff7b8bad36a::sbr {
    struct SBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBR>(arg0, 6, b"SBR", b"Suibara", x"54686520436170796261726120686173206265656e20696e746567726174656420696e746f2053756920696e206974732072656e6577656420666f726d2e200a5375696261726120697320612070726f6a65637420746861742067726f7773206f7267616e6963616c6c7920616e6420697320636f6d6d756e6974792d64726976656e2e200a497420697320612070726f6a65637420746861742061696d7320746f2067726f7720616e6420646576656c6f7020746f6765746865722077697468205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731072733092.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

