module 0x9824278d054dc51bb6b0a273432adde45c440e0bac5525652a8f52ba7ca40a0d::bub {
    struct BUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"nBubbleBridge";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = b"dAn ethereal cross-chain protocol connecting glass city states floating in a sea of liquid pearls. It charges zero gas fees but breaks completely if anyone speaks too loudly or makes sudden movements near the liquidity pool.";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<BUB>(arg0, 6, b"BUB", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidot.fun/i/9A0M-AI1KDrNvZ-e")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUB>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

