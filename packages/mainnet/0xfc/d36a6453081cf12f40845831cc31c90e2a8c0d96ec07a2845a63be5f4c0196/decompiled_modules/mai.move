module 0xfcd36a6453081cf12f40845831cc31c90e2a8c0d96ec07a2845a63be5f4c0196::mai {
    struct MAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAI>(arg0, 9, b"MAI", b"mainnet Test Token", b"Token on mainnet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

