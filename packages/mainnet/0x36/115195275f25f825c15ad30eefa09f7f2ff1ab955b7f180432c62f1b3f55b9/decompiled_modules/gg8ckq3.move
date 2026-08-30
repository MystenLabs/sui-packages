module 0x36115195275f25f825c15ad30eefa09f7f2ff1ab955b7f180432c62f1b3f55b9::gg8ckq3 {
    struct GG8CKQ3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG8CKQ3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG8CKQ3>(arg0, 0, b"GG8CKQ3", b"Sui Blue Gift Owner G8CKQ3", b"Sui Blue Gift mainnet Gift owner smoke token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GG8CKQ3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GG8CKQ3>>(0x2::coin::mint<GG8CKQ3>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG8CKQ3>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

