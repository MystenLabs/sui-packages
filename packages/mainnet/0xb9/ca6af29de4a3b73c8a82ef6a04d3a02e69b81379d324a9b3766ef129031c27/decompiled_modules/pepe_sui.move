module 0xb9ca6af29de4a3b73c8a82ef6a04d3a02e69b81379d324a9b3766ef129031c27::pepe_sui {
    struct PEPE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE_SUI>(arg0, 6, b"pSUI", b"Pepe Sui", b"t.me/PepeSuiChain", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

