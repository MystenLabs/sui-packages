module 0xd2d9d13c9ff820bf266b8c60e0f6bffa167dac3e8e4a1a9ef955874b21055179::Yusdc {
    struct YUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUSDC>(arg0, 6, b"Yusdc", b"Yusdc Coin", b"Yusdc Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://curator-liquidity-mainnet.haedal.xyz/coin-icons/husdc_05c1d6bec9.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUSDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUSDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

