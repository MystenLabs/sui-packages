module 0xa80f04830fb8ce7b546f35e7b9b1f471b7be041747a7a5c73c0d8e658fbaedf3::SUIVaultLPT {
    struct SUIVAULTLPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVAULTLPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVAULTLPT>(arg0, 9, b"SUI Vault LPT", b"SUI Vault LPT Coin", b"This token represents your deposited share in the Haedal Lending Vault. It automatically earns yield through optimized lending strategies across multiple protocols.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lv-curator.haedal.xyz/Lendvault/lpt/hsui_5bdd5e76.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIVAULTLPT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVAULTLPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

