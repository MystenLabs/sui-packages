module 0x655a6c147f83991d9030ed4a21a6f800fdb41ad34c0088be9c401ea2876bfa6f::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 9, b"SUI", b"Sui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI>>(v1);
    }

    public fun migrate_metadata(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &0x2::coin::CoinMetadata<SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::migrate_legacy_metadata<SUI>(arg0, arg1, arg2);
    }

    public fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI>>(0x2::coin::mint<SUI>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

