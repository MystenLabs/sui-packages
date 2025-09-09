module 0x90cb9a8b94284a541e0501df915ebf5a248df832d1098a8b5ce4f5d9a03c77f0::blp {
    struct BLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLP>(arg0, 6, b"BLP", b"Bluefin Liquidity Provider", b"This receipt token represents the shares a user has of the Bluefin Liquidity Provider (BLP) Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/eBLP.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

