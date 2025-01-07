module 0x3c157179a91dbab1d5b8f9a0a633b2727db8f18c987fe44e87cbe62d0f1ebd72::suirub {
    struct SUIRUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRUB>(arg0, 6, b"SUIRUB", b"Suirub The Hedgehog", b"Suirub is a community-managed project on #SUI, Elon's pet hedgehog and mascot of Tesla", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731516093158.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIRUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

