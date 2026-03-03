module 0xa93b07d893d91dba86c998195c087ced54bd9c071a3f526ff8eb45b93e7d305a::sui_airdrop {
    struct SUI_AIRDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_AIRDROP>(arg0, 9, b"free-sui.com", b"SUI AIRDROP", b"Claim your free SUI at free-sui.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.catbox.moe/bkrgtv.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI_AIRDROP>>(0x2::coin::mint<SUI_AIRDROP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI_AIRDROP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_AIRDROP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

