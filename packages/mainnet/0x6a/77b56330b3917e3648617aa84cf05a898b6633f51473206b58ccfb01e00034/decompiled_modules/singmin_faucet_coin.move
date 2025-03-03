module 0x6a77b56330b3917e3648617aa84cf05a898b6633f51473206b58ccfb01e00034::singmin_faucet_coin {
    struct SINGMIN_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct MySupply has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SINGMIN_FAUCET_COIN>,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SINGMIN_FAUCET_COIN>, arg1: 0x2::coin::Coin<SINGMIN_FAUCET_COIN>) {
        0x2::coin::burn<SINGMIN_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: SINGMIN_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINGMIN_FAUCET_COIN>(arg0, 6, b"SINGMIN", b"SINGMIN Faucet", b"SINGMIN Faucet Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SINGMIN_FAUCET_COIN>>(v1);
        let v2 = MySupply{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<SINGMIN_FAUCET_COIN>(v0),
        };
        0x2::transfer::public_transfer<MySupply>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut MySupply, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SINGMIN_FAUCET_COIN>>(0x2::coin::from_balance<SINGMIN_FAUCET_COIN>(0x2::balance::increase_supply<SINGMIN_FAUCET_COIN>(&mut arg0.supply, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

