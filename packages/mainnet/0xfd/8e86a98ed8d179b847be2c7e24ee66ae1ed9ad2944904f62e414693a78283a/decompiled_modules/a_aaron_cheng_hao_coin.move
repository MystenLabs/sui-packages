module 0xfd8e86a98ed8d179b847be2c7e24ee66ae1ed9ad2944904f62e414693a78283a::a_aaron_cheng_hao_coin {
    struct A_AARON_CHENG_HAO_COIN has drop {
        dummy_field: bool,
    }

    struct FaucetWallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<A_AARON_CHENG_HAO_COIN>,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<A_AARON_CHENG_HAO_COIN>, arg1: &mut FaucetWallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<A_AARON_CHENG_HAO_COIN>(&mut arg1.coin, 0x2::coin::into_balance<A_AARON_CHENG_HAO_COIN>(0x2::coin::mint<A_AARON_CHENG_HAO_COIN>(arg0, arg2, arg3)));
    }

    public entry fun faucet(arg0: &mut FaucetWallet, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<A_AARON_CHENG_HAO_COIN>>(0x2::coin::take<A_AARON_CHENG_HAO_COIN>(&mut arg0.coin, 10000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: A_AARON_CHENG_HAO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A_AARON_CHENG_HAO_COIN>(arg0, 6, b"A_AARON_CHENG_HAO_COIN", b"A_AARON_CHENG_HAO_COIN", b"I love A_AARON_CHENG_HAO_COIN. I love blockchains.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A_AARON_CHENG_HAO_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A_AARON_CHENG_HAO_COIN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = FaucetWallet{
            id   : 0x2::object::new(arg1),
            coin : 0x2::balance::zero<A_AARON_CHENG_HAO_COIN>(),
        };
        0x2::transfer::share_object<FaucetWallet>(v2);
    }

    // decompiled from Move bytecode v6
}

