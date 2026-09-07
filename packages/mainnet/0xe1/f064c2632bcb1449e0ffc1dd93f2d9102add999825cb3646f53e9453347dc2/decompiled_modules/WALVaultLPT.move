module 0xe1f064c2632bcb1449e0ffc1dd93f2d9102add999825cb3646f53e9453347dc2::WALVaultLPT {
    struct WALVAULTLPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALVAULTLPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALVAULTLPT>(arg0, 9, b"WAL Vault LPT", b"WAL Vault LPT Coin", b"This token represents your deposited share in the Haedal Lending Vault. It automatically earns yield through optimized lending strategies across multiple protocols.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://resources.haedal.xyz/Lendvault/lpt/walvaultlpt_e17840c9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WALVAULTLPT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALVAULTLPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

