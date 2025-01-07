module 0xec0bf98151a2772d1797ec9127930fcaba15f03b56b6653cf2d9b01db88716de::a_sky_person_faucet_coin {
    struct A_SKY_PERSON_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct FaucetWallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<A_SKY_PERSON_FAUCET_COIN>,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<A_SKY_PERSON_FAUCET_COIN>, arg1: &mut FaucetWallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<A_SKY_PERSON_FAUCET_COIN>(&mut arg1.coin, 0x2::coin::into_balance<A_SKY_PERSON_FAUCET_COIN>(0x2::coin::mint<A_SKY_PERSON_FAUCET_COIN>(arg0, arg2, arg3)));
    }

    public entry fun faucet(arg0: &mut FaucetWallet, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<A_SKY_PERSON_FAUCET_COIN>>(0x2::coin::take<A_SKY_PERSON_FAUCET_COIN>(&mut arg0.coin, 10000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: A_SKY_PERSON_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A_SKY_PERSON_FAUCET_COIN>(arg0, 6, b"A_SKY_PERSON_FAUCET_COIN", b"A_SKY_PERSON_FAUCET_COIN", b"I love A_SKY_PERSON_FAUCET_COIN. I love blockchains.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A_SKY_PERSON_FAUCET_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A_SKY_PERSON_FAUCET_COIN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = FaucetWallet{
            id   : 0x2::object::new(arg1),
            coin : 0x2::balance::zero<A_SKY_PERSON_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<FaucetWallet>(v2);
    }

    // decompiled from Move bytecode v6
}

