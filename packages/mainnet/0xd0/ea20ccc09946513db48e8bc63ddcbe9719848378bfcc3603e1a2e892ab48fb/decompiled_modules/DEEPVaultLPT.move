module 0xd0ea20ccc09946513db48e8bc63ddcbe9719848378bfcc3603e1a2e892ab48fb::DEEPVaultLPT {
    struct DEEPVAULTLPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPVAULTLPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPVAULTLPT>(arg0, 6, b"DEEP Vault LPT", b"DEEP Vault LPT Coin", b"This token represents your deposited share in the Haedal Lending Vault. It automatically earns yield through optimized lending strategies across multiple protocols.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://resources.haedal.xyz/Lendvault/lpt/deepvaultlpt_4eaa4386.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEEPVAULTLPT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPVAULTLPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

