module 0x7973b672eb4321cea11bf619047ce78713036c949e17a84e53c4d57e69beb5ce::brn0408 {
    struct BRN0408 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRN0408, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRN0408>(arg0, 9, b"BRN0408", b"Burn Token 720408", b"Burn-only token test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRN0408>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRN0408>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

