module 0xef7058b4f1611d5117663150dfa177c91ddb0d4047ac4ed2a287e5c380b8f60e::yield_token {
    struct YIELD_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YIELD_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YIELD_TOKEN>(arg0, 6, b"sUSDC", b"sUSDC", b"StableNest USDC yield-bearing token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/1skgv4ODTWSB01vM-rEcCnXgGNTUjBrnlu0BPT0I6kA")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YIELD_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YIELD_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

