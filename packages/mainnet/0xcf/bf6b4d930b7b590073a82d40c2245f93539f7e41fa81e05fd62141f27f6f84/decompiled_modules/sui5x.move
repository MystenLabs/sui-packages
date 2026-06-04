module 0xcfbf6b4d930b7b590073a82d40c2245f93539f7e41fa81e05fd62141f27f6f84::sui5x {
    struct SUI5X has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI5X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI5X>(arg0, 6, b"SUI5X", b"SUI5X", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI5X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI5X>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

