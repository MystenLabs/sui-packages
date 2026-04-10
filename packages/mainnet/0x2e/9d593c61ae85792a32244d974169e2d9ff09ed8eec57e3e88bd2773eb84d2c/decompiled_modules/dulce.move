module 0x2e9d593c61ae85792a32244d974169e2d9ff09ed8eec57e3e88bd2773eb84d2c::dulce {
    struct DULCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DULCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DULCE>(arg0, 6, b"DULCE", b"DULCE", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DULCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DULCE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

