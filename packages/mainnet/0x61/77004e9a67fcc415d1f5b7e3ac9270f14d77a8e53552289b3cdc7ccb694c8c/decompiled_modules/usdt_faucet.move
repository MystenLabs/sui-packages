module 0x6177004e9a67fcc415d1f5b7e3ac9270f14d77a8e53552289b3cdc7ccb694c8c::usdt_faucet {
    struct USDT_FAUCET has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDT_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT_FAUCET>>(0x2::coin::mint<USDT_FAUCET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: USDT_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT_FAUCET>(arg0, 6, b"USDT", b"Tether USD", b"Test USDT token for testnet development and testing purposes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bridge-assets.sui.io/usdt.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

