module 0xe25609fb51f46edc1bcf56482331e5357cfeaec812d564f6a146e42fe80760b0::lpcoin {
    struct LPCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPCOIN>(arg0, 6, b"SUI-USDC Vault LPT", b"SUI-USDC Haedal Vault LP Token", b"Haedal Vault LP Token, SUI-USDC Pool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://node1.irys.xyz/TZD49BnoQJTbSIsGi_qfnzfN0MuCE17hYMeOWaMqpEs")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

