module 0x3550f7aaa71e99c41126e76420205dabb218db16481f778cd31b9a3d922aaa54::test1 {
    struct TEST1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST1>(arg0, 6, b"TEST1", b"TEST1", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST1>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

