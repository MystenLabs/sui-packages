module 0x2c058ff0f54cc1a7942c7d81e98c342b84b4ae945c42eb6165e97ce2583db726::dyjj_faucet {
    struct DYJJ_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYJJ_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYJJ_FAUCET>(arg0, 9, b"Dyjj-faucet", b"dyjj_faucet", b"Dyjj_token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"http://i2.hdslb.com/bfs/face/a959c72407b2ac553d4328fd76d55d0134e20f65.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DYJJ_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<DYJJ_FAUCET>>(v0);
    }

    public entry fun mint_in_my_module(arg0: &mut 0x2::coin::TreasuryCap<DYJJ_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DYJJ_FAUCET>>(0x2::coin::mint<DYJJ_FAUCET>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

