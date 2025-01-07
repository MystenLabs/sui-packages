module 0x40ae3935e2eeb5c9ccccef3d348486edfbb9fbb6f3dcc60ab0f9ed04aa0c99b6::faucet_coin_demo {
    struct FAUCET_COIN_DEMO has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN_DEMO>, arg1: 0x2::coin::Coin<FAUCET_COIN_DEMO>) {
        0x2::coin::burn<FAUCET_COIN_DEMO>(arg0, arg1);
    }

    fun init(arg0: FAUCET_COIN_DEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_COIN_DEMO>(arg0, 2, b"5255b64F", b"5255b64's faucet coin", b"5255b64's faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_COIN_DEMO>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_COIN_DEMO>>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN_DEMO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FAUCET_COIN_DEMO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

