module 0xb603830bdae7082b9bca4a87ba84fe0c7faf8eb7c53b1b148409a5acbb668a9d::sUSDY {
    struct SUSDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSDY>(arg0, 6, b"sysUSDY", b"SY sUSDY", b"SY scallop sUSDY", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

