module 0xec15337b855a4d7aa067f9b138824631895b0ab6b60d5f62eefd56f869f9bdc3::xiba {
    struct XIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIBA>(arg0, 9, b"XIBA", b"XIBA", b"XIBA is the future of decentralized finance. Community driven and transparent.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XIBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

