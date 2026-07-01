module 0x6a16a03b22835ae79bb0a091853bebc5b76d157b27b28a408368ddd4cbfe9c35::shadow_coin {
    struct SHADOW_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHADOW_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHADOW_COIN>>(0x2::coin::mint<SHADOW_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHADOW_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHADOW_COIN>(arg0, 9, b"SHADOW", b"Shadow LP Farm Validation Coin", b"Disposable validation coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHADOW_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHADOW_COIN>>(v1);
    }

    // decompiled from Move bytecode v7
}

