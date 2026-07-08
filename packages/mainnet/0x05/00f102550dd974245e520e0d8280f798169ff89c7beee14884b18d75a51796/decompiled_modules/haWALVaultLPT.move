module 0x500f102550dd974245e520e0d8280f798169ff89c7beee14884b18d75a51796::haWALVaultLPT {
    struct HAWALVAULTLPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWALVAULTLPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAWALVAULTLPT>(arg0, 9, b"haWAL Vault LPT", b"Haedal Lending Vault LP Token", b"This token represents your deposited share in the Haedal Lending Vault. It automatically earns yield through optimized lending strategies across multiple protocols.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://resources.haedal.xyz/Lendvault/lpt/hawalvaultlpt_0e543ef0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAWALVAULTLPT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAWALVAULTLPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

