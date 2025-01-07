module 0x8865d5e7cedd69aa766fb758b2436b54439546e6e6956050e2c146dc228738ff::faucet_coin {
    struct FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct TreasuryCaoHolder has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<FAUCET_COIN>,
    }

    public entry fun mint(arg0: &mut TreasuryCaoHolder, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCET_COIN>>(0x2::coin::mint<FAUCET_COIN>(&mut arg0.treasury_cap, 10, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_COIN>(arg0, 6, b"looikaizhi_Faucet", b"LKZF", b"Who can let me become a memecoin!!(This is faucet)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_COIN>>(v1);
        let v2 = TreasuryCaoHolder{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<TreasuryCaoHolder>(v2);
    }

    // decompiled from Move bytecode v6
}

