module 0xa06247df0859c7dff209bb56c1835e3ff4f7c48bc008cfcbd8e57ace5b81c111::a_604137978_faucet {
    struct A_604137978_FAUCET has drop {
        dummy_field: bool,
    }

    struct PublicWallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<A_604137978_FAUCET>,
        faucet_amount: u64,
    }

    public entry fun get_faucet(arg0: &mut PublicWallet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<A_604137978_FAUCET>(&arg0.coin) >= arg0.faucet_amount, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<A_604137978_FAUCET>>(0x2::coin::from_balance<A_604137978_FAUCET>(0x2::balance::split<A_604137978_FAUCET>(&mut arg0.coin, arg0.faucet_amount), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: A_604137978_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A_604137978_FAUCET>(arg0, 10, b"A_604137978 Faucet", b"A_604137978 Faucet", b"Meme Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A_604137978_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A_604137978_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = PublicWallet{
            id            : 0x2::object::new(arg1),
            coin          : 0x2::balance::zero<A_604137978_FAUCET>(),
            faucet_amount : 6,
        };
        0x2::transfer::share_object<PublicWallet>(v2);
    }

    public entry fun mint_faucet(arg0: &mut 0x2::coin::TreasuryCap<A_604137978_FAUCET>, arg1: u64, arg2: &mut PublicWallet, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<A_604137978_FAUCET>(&mut arg2.coin, 0x2::coin::into_balance<A_604137978_FAUCET>(0x2::coin::mint<A_604137978_FAUCET>(arg0, arg1, arg3)));
    }

    // decompiled from Move bytecode v6
}

