module 0x80c572b8e137443fa7c6a0f8edc34a570c6cf1cbdd44b7a29c6345071c878f94::hWAL {
    struct HWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HWAL>(arg0, 9, b"hWAL", b"hWAL Coin", b"hWAL Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://curator-liquidity-mainnet.haedal.xyz/coin-icons/hwal_6bae4789a5_69387.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HWAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

