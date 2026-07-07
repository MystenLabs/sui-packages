module 0x20a0575245065a5c1ebc3f653b460abaacc9b4a6d5a558db9af82c7bbbbf8561::suiUSDTVaultLPT {
    struct SUIUSDTVAULTLPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIUSDTVAULTLPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIUSDTVAULTLPT>(arg0, 6, b"suiUSDT Vault LPT", b"suiUSDT Vault LPT Coin", b"This token represents your deposited share in the Haedal Lending Vault. It automatically earns yield through optimized lending strategies across multiple protocols.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://resources.haedal.xyz/Lendvault/lpt/suiusdtvaultlpt_bfed1c77.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIUSDTVAULTLPT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIUSDTVAULTLPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

