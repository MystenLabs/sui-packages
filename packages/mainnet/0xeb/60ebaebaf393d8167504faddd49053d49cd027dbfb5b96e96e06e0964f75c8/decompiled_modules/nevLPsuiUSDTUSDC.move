module 0xeb60ebaebaf393d8167504faddd49053d49cd027dbfb5b96e96e06e0964f75c8::nevLPsuiUSDTUSDC {
    struct NEVLPSUIUSDTUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEVLPSUIUSDTUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEVLPSUIUSDTUSDC>(arg0, 9, b"synevLPsuiUSDTUSDC", b"SY nevLPsuiUSDTUSDC", b"SY nevLP suiUSDT-USDC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEVLPSUIUSDTUSDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEVLPSUIUSDTUSDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

