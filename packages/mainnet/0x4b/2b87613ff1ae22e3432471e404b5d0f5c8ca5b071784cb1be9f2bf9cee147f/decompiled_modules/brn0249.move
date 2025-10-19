module 0x4b2b87613ff1ae22e3432471e404b5d0f5c8ca5b071784cb1be9f2bf9cee147f::brn0249 {
    struct BRN0249 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRN0249, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRN0249>(arg0, 9, b"BRN0249", b"Burn Token 470249", b"Burn-only token test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRN0249>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRN0249>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

