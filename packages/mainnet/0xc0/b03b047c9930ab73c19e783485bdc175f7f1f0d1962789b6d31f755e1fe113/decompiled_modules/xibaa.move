module 0xc0b03b047c9930ab73c19e783485bdc175f7f1f0d1962789b6d31f755e1fe113::xibaa {
    struct XIBAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIBAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIBAA>(arg0, 6, b"XIBAA", b"XIBAA", b"XIBAA is the future of decentralized finance. Community driven and transparent.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XIBAA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIBAA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

