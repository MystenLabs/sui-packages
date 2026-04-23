module 0x1f92292041c50df7b64f770d2c97215919ca8c3ac3b11efa22b3c25733367889::iwfe {
    struct IWFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IWFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IWFE>(arg0, 6, b"IWFE", b"IWFE", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IWFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IWFE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

