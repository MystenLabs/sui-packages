module 0x9f4147dedf3fb03a3314db8262bdccf6be43794ab8f1496571b91bc42228ee1f::A1LinLin1_faucet_coin {
    struct A1LINLIN1_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct FaucetWallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<A1LINLIN1_FAUCET_COIN>,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<A1LINLIN1_FAUCET_COIN>, arg1: &mut FaucetWallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<A1LINLIN1_FAUCET_COIN>(&mut arg1.coin, 0x2::coin::into_balance<A1LINLIN1_FAUCET_COIN>(0x2::coin::mint<A1LINLIN1_FAUCET_COIN>(arg0, arg2, arg3)));
    }

    public entry fun faucet(arg0: &mut FaucetWallet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<A1LINLIN1_FAUCET_COIN>(&arg0.coin) >= 10000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<A1LINLIN1_FAUCET_COIN>>(0x2::coin::take<A1LINLIN1_FAUCET_COIN>(&mut arg0.coin, 10000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: A1LINLIN1_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A1LINLIN1_FAUCET_COIN>(arg0, 6, b"A1LinLin1_faucet_coin", b"A1LinLin1_faucet_coin", b"I love A1LinLin1_faucet_coin. I love blockchains.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A1LINLIN1_FAUCET_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A1LINLIN1_FAUCET_COIN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = FaucetWallet{
            id   : 0x2::object::new(arg1),
            coin : 0x2::balance::zero<A1LINLIN1_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<FaucetWallet>(v2);
    }

    // decompiled from Move bytecode v6
}

