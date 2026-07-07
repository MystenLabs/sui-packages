module 0x86d1ea26c3ea02e463238f668c6983c66da162fe6789c367b0490f4877d20bc8::USDsuiVaultLPT {
    struct USDSUIVAULTLPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDSUIVAULTLPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDSUIVAULTLPT>(arg0, 6, b"USDsui Vault LPT", b"USDsui Vault LPT Coin", b"This token represents your deposited share in the Haedal Lending Vault. It automatically earns yield through optimized lending strategies across multiple protocols.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://resources.haedal.xyz/Lendvault/lpt/usdsuivaultlpt_96957a33.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDSUIVAULTLPT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDSUIVAULTLPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

