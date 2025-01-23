module 0x31ea20de2f0b392a7e0460c6bd17f43863a2b0fef503b0fe3c4628d4a2c22cc9::sWUSDC {
    struct SWUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWUSDC>(arg0, 9, b"sysWUSDC", b"SY sWUSDC", b"SY scallop sUSDC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWUSDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWUSDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

