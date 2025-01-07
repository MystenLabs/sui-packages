module 0x2cdd34202d285b2f4579955b57cb29cfd1c7ac9178cdc0d8424e47eb0c7a4016::xdd_object {
    struct XDD_OBJECT has drop {
        dummy_field: bool,
    }

    fun init(arg0: XDD_OBJECT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XDD_OBJECT>(arg0, 9, b"XDD_OBJECT", b"XDD_OBJECT", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XDD_OBJECT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XDD_OBJECT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_xdd_object(arg0: &mut 0x2::coin::TreasuryCap<XDD_OBJECT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XDD_OBJECT>>(0x2::coin::mint<XDD_OBJECT>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

