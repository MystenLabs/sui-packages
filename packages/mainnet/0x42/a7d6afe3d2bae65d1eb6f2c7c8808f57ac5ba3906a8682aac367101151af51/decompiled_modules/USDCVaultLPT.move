module 0x42a7d6afe3d2bae65d1eb6f2c7c8808f57ac5ba3906a8682aac367101151af51::USDCVaultLPT {
    struct USDCVAULTLPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDCVAULTLPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDCVAULTLPT>(arg0, 6, b"USDC Vault LPT", b"USDC Vault LPT Coin", b"This token represents your deposited share in the Haedal Lending Vault. It automatically earns yield through optimized lending strategies across multiple protocols.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://resources.haedal.xyz/Lendvault/lpt/husdc_3c2c1a22.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDCVAULTLPT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDCVAULTLPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

