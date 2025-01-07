module 0x954e65d87e81538a4fcd5099da79d16a6ddbe3ef6e92156caff66817987193a5::faucet_coin {
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
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_COIN>(arg0, 6, b"qiaopengjun5162", b"qiaopengjun5162Faucet", b"qiaopengjun5162 Faucet Coin", 0x1::option::none<0x2::url::Url>(), arg1);
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

