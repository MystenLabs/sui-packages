module 0x6d3c170d8cea5beb4a7ade72e6de0e6556bd45ab2e37203bc392d4050ce16636::haSUIVaultLPT {
    struct HASUIVAULTLPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASUIVAULTLPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASUIVAULTLPT>(arg0, 9, b"haSUI Vault LPT", b"haSUI Vault LPT Coin", b"This token represents your deposited share in the Haedal Lending Vault. It automatically earns yield through optimized lending strategies across multiple protocols.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://resources.haedal.xyz/Lendvault/lpt/hasuivaultlpt_43ccea89.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HASUIVAULTLPT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASUIVAULTLPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

