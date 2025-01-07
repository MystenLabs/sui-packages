module 0xd759fda433607390946753c250ac07ba508aad83ca5c1041ab7a599a45d6f60::toma3610_faucet {
    struct TOMA3610_FAUCET has drop {
        dummy_field: bool,
    }

    struct PublicWallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<TOMA3610_FAUCET>,
        faucet_amount: u64,
    }

    public entry fun get_faucet(arg0: &mut PublicWallet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<TOMA3610_FAUCET>(&arg0.coin) >= arg0.faucet_amount, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOMA3610_FAUCET>>(0x2::coin::from_balance<TOMA3610_FAUCET>(0x2::balance::split<TOMA3610_FAUCET>(&mut arg0.coin, arg0.faucet_amount), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: TOMA3610_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMA3610_FAUCET>(arg0, 10, b"Toma3610 Faucet", b"Toma3610 Faucet", b"Get some free coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOMA3610_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMA3610_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = PublicWallet{
            id            : 0x2::object::new(arg1),
            coin          : 0x2::balance::zero<TOMA3610_FAUCET>(),
            faucet_amount : 6,
        };
        0x2::transfer::share_object<PublicWallet>(v2);
    }

    public entry fun mint_faucet(arg0: &mut 0x2::coin::TreasuryCap<TOMA3610_FAUCET>, arg1: u64, arg2: &mut PublicWallet, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<TOMA3610_FAUCET>(&mut arg2.coin, 0x2::coin::into_balance<TOMA3610_FAUCET>(0x2::coin::mint<TOMA3610_FAUCET>(arg0, arg1, arg3)));
    }

    // decompiled from Move bytecode v6
}

