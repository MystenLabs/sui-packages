module 0x713d26c23cfc715468c148fffa2cdc76eef83105b4a52aa9084230b71cd7d95::xibaa {
    struct XIBAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIBAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIBAA>(arg0, 9, b"XIBAA", b"XIBAA", b"XIBAA is the future of decentralized finance. Community driven and transparent.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XIBAA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIBAA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

