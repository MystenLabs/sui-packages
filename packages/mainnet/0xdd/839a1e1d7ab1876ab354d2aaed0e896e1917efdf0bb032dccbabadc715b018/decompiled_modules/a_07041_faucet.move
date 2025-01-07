module 0xdd839a1e1d7ab1876ab354d2aaed0e896e1917efdf0bb032dccbabadc715b018::a_07041_faucet {
    struct A_07041_FAUCET has drop {
        dummy_field: bool,
    }

    struct PublicWallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<A_07041_FAUCET>,
        faucet_amount: u64,
    }

    public entry fun get_faucet(arg0: &mut PublicWallet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<A_07041_FAUCET>(&arg0.coin) >= arg0.faucet_amount, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<A_07041_FAUCET>>(0x2::coin::from_balance<A_07041_FAUCET>(0x2::balance::split<A_07041_FAUCET>(&mut arg0.coin, arg0.faucet_amount), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: A_07041_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A_07041_FAUCET>(arg0, 10, b"A_07041 Faucet", b"A_07041 Faucet", b"Meme Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A_07041_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A_07041_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = PublicWallet{
            id            : 0x2::object::new(arg1),
            coin          : 0x2::balance::zero<A_07041_FAUCET>(),
            faucet_amount : 6,
        };
        0x2::transfer::share_object<PublicWallet>(v2);
    }

    public entry fun mint_faucet(arg0: &mut 0x2::coin::TreasuryCap<A_07041_FAUCET>, arg1: u64, arg2: &mut PublicWallet, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<A_07041_FAUCET>(&mut arg2.coin, 0x2::coin::into_balance<A_07041_FAUCET>(0x2::coin::mint<A_07041_FAUCET>(arg0, arg1, arg3)));
    }

    // decompiled from Move bytecode v6
}

