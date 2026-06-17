module 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::mock_usdc {
    struct MOCK_USDC has drop {
        dummy_field: bool,
    }

    public fun faucet(arg0: &mut 0x2::coin::TreasuryCap<MOCK_USDC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MOCK_USDC> {
        0x2::coin::mint<MOCK_USDC>(arg0, arg1, arg2)
    }

    public fun faucet_to(arg0: &mut 0x2::coin::TreasuryCap<MOCK_USDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCK_USDC>>(0x2::coin::mint<MOCK_USDC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOCK_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCK_USDC>(arg0, 6, b"mUSDC", b"Mock USDC", b"USDC gia lap cho parimutuel tren devnet - KHONG phai tien that", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCK_USDC>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MOCK_USDC>>(v0);
    }

    // decompiled from Move bytecode v7
}

