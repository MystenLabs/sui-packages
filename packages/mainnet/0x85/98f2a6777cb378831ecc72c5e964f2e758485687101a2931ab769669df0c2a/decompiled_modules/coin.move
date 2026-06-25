module 0x8598f2a6777cb378831ecc72c5e964f2e758485687101a2931ab769669df0c2a::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 6, b"USDC", b"USD Coin", b"Wormhole-bridged USD Coin from Ethereum.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wormhole.com/")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN>>(v1);
    }

    // decompiled from Move bytecode v7
}

