module 0xdb674006027402dda2a8a7fa1069c0f12c55290d361f2449769730a7a1fd89b6::lp_usdc_sui {
    struct LP_USDC_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LP_USDC_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP_USDC_SUI>(arg0, 9, b"steammLP bUSDC-bSUI", b"Steamm LP Token bUSDC-bSUI", b"Steamm LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP_USDC_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LP_USDC_SUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

