module 0x8d576c29c763fc625440d296bfca79bfe75dea9b268da5bf396e5fc81c70e5fa::SUI_USDC1_V3 {
    struct SUI_USDC1_V3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_USDC1_V3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_USDC1_V3>(arg0, 6, b"SUI_USDC1_V3", b"SUI_USDC1_V3", b"staging kriya V3 vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_USDC1_V3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_USDC1_V3>>(v1);
    }

    // decompiled from Move bytecode v6
}

