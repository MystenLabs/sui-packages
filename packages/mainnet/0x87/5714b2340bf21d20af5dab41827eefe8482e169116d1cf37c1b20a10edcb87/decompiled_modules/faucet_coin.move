module 0x875714b2340bf21d20af5dab41827eefe8482e169116d1cf37c1b20a10edcb87::faucet_coin {
    struct FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct MySupply has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<FAUCET_COIN>,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: 0x2::coin::Coin<FAUCET_COIN>) {
        0x2::coin::burn<FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_COIN>(arg0, 6, b"sugarcanecat", b"sugarcanecat", b"sugarcanecat Faucet Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAUCET_COIN>>(v1);
        let v2 = MySupply{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<FAUCET_COIN>(v0),
        };
        0x2::transfer::public_transfer<MySupply>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut MySupply, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCET_COIN>>(0x2::coin::from_balance<FAUCET_COIN>(0x2::balance::increase_supply<FAUCET_COIN>(&mut arg0.supply, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

