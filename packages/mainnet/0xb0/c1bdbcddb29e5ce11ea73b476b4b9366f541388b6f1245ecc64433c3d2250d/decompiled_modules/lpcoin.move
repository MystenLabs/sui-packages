module 0xb0c1bdbcddb29e5ce11ea73b476b4b9366f541388b6f1245ecc64433c3d2250d::lpcoin {
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

