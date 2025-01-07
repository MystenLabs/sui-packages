module 0xf53584162d3bea7fb20270f22a5a49f0d56a85beeb8c1fd3e56ea2033e547e84::ajin8898_faucet_coin {
    struct AJIN8898_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct PublicWallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<AJIN8898_FAUCET_COIN>,
        faucet_amount: u64,
    }

    public entry fun get_faucet(arg0: &mut PublicWallet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<AJIN8898_FAUCET_COIN>(&arg0.coin) >= arg0.faucet_amount, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AJIN8898_FAUCET_COIN>>(0x2::coin::from_balance<AJIN8898_FAUCET_COIN>(0x2::balance::split<AJIN8898_FAUCET_COIN>(&mut arg0.coin, arg0.faucet_amount), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: AJIN8898_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AJIN8898_FAUCET_COIN>(arg0, 10, b"ajin8898 Faucet coin", b"ajin8898 Faucet coin", b"Get some free coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AJIN8898_FAUCET_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AJIN8898_FAUCET_COIN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = PublicWallet{
            id            : 0x2::object::new(arg1),
            coin          : 0x2::balance::zero<AJIN8898_FAUCET_COIN>(),
            faucet_amount : 6,
        };
        0x2::transfer::share_object<PublicWallet>(v2);
    }

    public entry fun mint_faucet(arg0: &mut 0x2::coin::TreasuryCap<AJIN8898_FAUCET_COIN>, arg1: u64, arg2: &mut PublicWallet, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<AJIN8898_FAUCET_COIN>(&mut arg2.coin, 0x2::coin::into_balance<AJIN8898_FAUCET_COIN>(0x2::coin::mint<AJIN8898_FAUCET_COIN>(arg0, arg1, arg3)));
    }

    // decompiled from Move bytecode v6
}

