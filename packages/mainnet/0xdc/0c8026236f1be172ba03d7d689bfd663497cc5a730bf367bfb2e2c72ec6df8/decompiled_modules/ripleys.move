module 0xdc0c8026236f1be172ba03d7d689bfd663497cc5a730bf367bfb2e2c72ec6df8::ripleys {
    struct RIPLEYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIPLEYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIPLEYS>(arg0, 6, b"ripleysSUI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIPLEYS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIPLEYS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

