module 0xf73cc20120f64c23f6efaac750836c0e60ebb18064d12b222866b2796fd9e69e::SUIVaultLPT {
    struct SUIVAULTLPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVAULTLPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVAULTLPT>(arg0, 9, b"SUI Vault LPT", b"Haedal Lending Vault LP Token", b"This token represents your deposited share in the Haedal Lending Vault. It automatically earns yield through optimized lending strategies across multiple protocols.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://resources.haedal.xyz/Lendvault/lpt/hsui_c5c43be3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIVAULTLPT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVAULTLPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

