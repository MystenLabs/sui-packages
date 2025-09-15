module 0xef7dd24677b60d48c0296938cce2178487587fcc2fdb7ae09a21c83d0a68224::water_finance {
    struct WATER_FINANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATER_FINANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATER_FINANCE>(arg0, 6, b"WATER", b"LP token for Water Finance saving pool", b"Water Finance USDC Vault", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/B64DHJQ2/Chat-GPT-Image-Aug-22-2025-12-46-26-PM.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATER_FINANCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WATER_FINANCE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

