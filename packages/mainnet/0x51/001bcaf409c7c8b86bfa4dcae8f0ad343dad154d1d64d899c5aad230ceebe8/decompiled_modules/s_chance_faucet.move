module 0x51001bcaf409c7c8b86bfa4dcae8f0ad343dad154d1d64d899c5aad230ceebe8::s_chance_faucet {
    struct S_CHANCE_FAUCET has drop {
        dummy_field: bool,
    }

    struct PublicWallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<S_CHANCE_FAUCET>,
        faucet_amount: u64,
    }

    public entry fun get_faucet(arg0: &mut PublicWallet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<S_CHANCE_FAUCET>(&arg0.coin) >= arg0.faucet_amount, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<S_CHANCE_FAUCET>>(0x2::coin::from_balance<S_CHANCE_FAUCET>(0x2::balance::split<S_CHANCE_FAUCET>(&mut arg0.coin, arg0.faucet_amount), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: S_CHANCE_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S_CHANCE_FAUCET>(arg0, 10, b"S_chance Faucet", b"S_chance Faucet", b"Get some free coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S_CHANCE_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S_CHANCE_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = PublicWallet{
            id            : 0x2::object::new(arg1),
            coin          : 0x2::balance::zero<S_CHANCE_FAUCET>(),
            faucet_amount : 6,
        };
        0x2::transfer::share_object<PublicWallet>(v2);
    }

    public entry fun mint_faucet(arg0: &mut 0x2::coin::TreasuryCap<S_CHANCE_FAUCET>, arg1: u64, arg2: &mut PublicWallet, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<S_CHANCE_FAUCET>(&mut arg2.coin, 0x2::coin::into_balance<S_CHANCE_FAUCET>(0x2::coin::mint<S_CHANCE_FAUCET>(arg0, arg1, arg3)));
    }

    // decompiled from Move bytecode v6
}

