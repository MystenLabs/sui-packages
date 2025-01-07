module 0xf6589e809a54abe3d583371ba82f24206fe01a3f25b6a38db02d82ba6427ce05::web3richer_faucet_coin {
    struct WEB3RICHER_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<WEB3RICHER_FAUCET_COIN>, arg1: 0x2::coin::Coin<WEB3RICHER_FAUCET_COIN>) {
        0x2::coin::burn<WEB3RICHER_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: WEB3RICHER_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEB3RICHER_FAUCET_COIN>(arg0, 8, b"WRCF", b"Web3Richer Faucet Coin", b"the faucet coin for web3richer", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEB3RICHER_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<WEB3RICHER_FAUCET_COIN>>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WEB3RICHER_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WEB3RICHER_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

