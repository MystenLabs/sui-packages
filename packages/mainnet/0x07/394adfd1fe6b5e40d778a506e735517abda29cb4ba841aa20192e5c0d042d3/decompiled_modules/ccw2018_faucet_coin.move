module 0x7394adfd1fe6b5e40d778a506e735517abda29cb4ba841aa20192e5c0d042d3::ccw2018_faucet_coin {
    struct CCW2018_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CCW2018_FAUCET_COIN>, arg1: 0x2::coin::Coin<CCW2018_FAUCET_COIN>) {
        0x2::coin::burn<CCW2018_FAUCET_COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CCW2018_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CCW2018_FAUCET_COIN>>(0x2::coin::mint<CCW2018_FAUCET_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CCW2018_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCW2018_FAUCET_COIN>(arg0, 6, b"ccw2018_faucet_coin", b"ccw2018_faucet_coin name", b"ccw2018_faucet_coin description", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCW2018_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CCW2018_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

