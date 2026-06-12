module 0xfcd5073eab33f063964d3d98963df9750b5535e265d40d81c3525d90911c4a86::hSUIUSDT {
    struct HSUIUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSUIUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSUIUSDT>(arg0, 6, b"hSUIUSDT", b"hSUIUSDT Coin", b"hSUIUSDT Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://curator-liquidity-mainnet.haedal.xyz/coin-icons/hsuiusdt_890e145ec0.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HSUIUSDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSUIUSDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

