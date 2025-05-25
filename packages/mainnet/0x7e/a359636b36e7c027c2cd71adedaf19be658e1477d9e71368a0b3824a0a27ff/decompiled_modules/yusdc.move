module 0x7ea359636b36e7c027c2cd71adedaf19be658e1477d9e71368a0b3824a0a27ff::yusdc {
    struct YUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUSDC>(arg0, 6, b"yUSDC-2", b"Kai Vault USDC", b"Kai Vault yield-bearing USDC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUSDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUSDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

