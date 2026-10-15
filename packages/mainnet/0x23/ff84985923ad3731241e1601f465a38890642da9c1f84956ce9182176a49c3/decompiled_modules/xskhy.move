module 0x23ff84985923ad3731241e1601f465a38890642da9c1f84956ce9182176a49c3::xskhy {
    struct XSKHY has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XSKHY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XSKHY>>(0x2::coin::mint<XSKHY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: XSKHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSKHY>(arg0, 9, b"xSKHY", b"xSKHY", b"xSKHY (Sui Coin standard).", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XSKHY>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XSKHY>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

