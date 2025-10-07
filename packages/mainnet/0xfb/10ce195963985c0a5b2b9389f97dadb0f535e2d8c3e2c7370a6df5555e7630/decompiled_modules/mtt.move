module 0xfb10ce195963985c0a5b2b9389f97dadb0f535e2d8c3e2c7370a6df5555e7630::mtt {
    struct MTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTT>(arg0, 9, b"MTT", b"mainnet Test Token", b"Token deployed on mainnet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

