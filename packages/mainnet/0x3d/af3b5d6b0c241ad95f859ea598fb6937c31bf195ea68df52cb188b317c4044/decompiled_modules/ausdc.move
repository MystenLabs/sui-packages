module 0x3daf3b5d6b0c241ad95f859ea598fb6937c31bf195ea68df52cb188b317c4044::ausdc {
    struct AUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUSDC>(arg0, 6, b"aUSDC", b"Alakazam USDC", b"Test USDC for Alakazam staging trial-user testing", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUSDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUSDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

