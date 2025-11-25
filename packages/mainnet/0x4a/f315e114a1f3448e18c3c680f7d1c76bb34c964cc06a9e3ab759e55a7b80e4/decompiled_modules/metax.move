module 0x4af315e114a1f3448e18c3c680f7d1c76bb34c964cc06a9e3ab759e55a7b80e4::metax {
    struct METAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: METAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METAX>(arg0, 9, b"METAX", b"MetaX", b"ZO Virtual Coin for Meta X Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<METAX>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<METAX>>(v0);
    }

    // decompiled from Move bytecode v6
}

