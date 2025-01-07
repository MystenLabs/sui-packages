module 0x72a68fa0606318516b8f5963e428c4e30840dd0116c7a84580809c287241c03a::dcm_coin {
    struct DCM_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DCM_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DCM_COIN>>(0x2::coin::mint<DCM_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DCM_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCM_COIN>(arg0, 6, b"dcming666", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCM_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCM_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

