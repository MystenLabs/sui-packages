module 0x4489b5ca0897e4c5d720a23ab6f6b5c6fd92b0b9595414952eef7dee3174a444::test_usdc {
    struct TEST_USDC has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST_USDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST_USDC>>(0x2::coin::mint<TEST_USDC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TEST_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_USDC>(arg0, 6, b"tUSDC", b"Test USDC", b"Testnet USDC for HypersFun E2E testing", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TEST_USDC>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_USDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

