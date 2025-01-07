module 0xc7c04d9921908a14064522e2265a20d11b13e215133ee60b5387abfa677b32c::web3richer_coin {
    struct WEB3RICHER_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEB3RICHER_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEB3RICHER_COIN>(arg0, 8, b"WRC", b"Web3Richer Coin", b"the coin for web3richer", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEB3RICHER_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEB3RICHER_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WEB3RICHER_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WEB3RICHER_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

