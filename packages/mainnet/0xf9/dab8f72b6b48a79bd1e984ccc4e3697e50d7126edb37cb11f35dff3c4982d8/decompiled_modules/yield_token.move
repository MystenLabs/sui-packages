module 0xf9dab8f72b6b48a79bd1e984ccc4e3697e50d7126edb37cb11f35dff3c4982d8::yield_token {
    struct YIELD_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YIELD_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YIELD_TOKEN>(arg0, 6, b"vUSDC", b"Vault USDC Yield Token", b"Vault yield-bearing USDC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YIELD_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YIELD_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

