module 0xad0e8e0025aacc060e0e9a304c02a9e6ee7616320b4b32c967519d2aacaaf696::lpcoin {
    struct LPCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LPCOIN>(arg0, 6, 0x1::string::utf8(b"SUI-USDC Vault LPT"), 0x1::string::utf8(b"SUI-USDC Haedal Vault LP Token"), 0x1::string::utf8(b"Haedal Vault LP Token, SUI-USDC Pool"), 0x1::string::utf8(b"https://node1.irys.xyz/TZD49BnoQJTbSIsGi_qfnzfN0MuCE17hYMeOWaMqpEs"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LPCOIN>>(0x2::coin_registry::finalize<LPCOIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

