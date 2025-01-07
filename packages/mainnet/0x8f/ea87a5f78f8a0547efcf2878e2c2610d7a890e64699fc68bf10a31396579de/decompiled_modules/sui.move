module 0x8fea87a5f78f8a0547efcf2878e2c2610d7a890e64699fc68bf10a31396579de::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 2, b"SUI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SUI>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

