module 0x91fd665c1d0a5cffa316da511777f27491245defcfefee2790ee18aaa64de70d::reetyo_faucet {
    struct REETYO_FAUCET has drop {
        dummy_field: bool,
    }

    struct PublicWallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<REETYO_FAUCET>,
        faucet_amount: u64,
    }

    public entry fun get_faucet(arg0: &mut PublicWallet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<REETYO_FAUCET>(&arg0.coin) >= arg0.faucet_amount, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<REETYO_FAUCET>>(0x2::coin::from_balance<REETYO_FAUCET>(0x2::balance::split<REETYO_FAUCET>(&mut arg0.coin, arg0.faucet_amount), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: REETYO_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REETYO_FAUCET>(arg0, 10, b"Reetyo Faucet", b"Reetyo Faucet", b"Get some free coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REETYO_FAUCET>>(v1);
        let v2 = PublicWallet{
            id            : 0x2::object::new(arg1),
            coin          : 0x2::balance::zero<REETYO_FAUCET>(),
            faucet_amount : 6,
        };
        0x2::transfer::share_object<PublicWallet>(v2);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<REETYO_FAUCET>>(v0);
    }

    public entry fun mint_faucet(arg0: &mut 0x2::coin::TreasuryCap<REETYO_FAUCET>, arg1: u64, arg2: &mut PublicWallet, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<REETYO_FAUCET>(&mut arg2.coin, 0x2::coin::into_balance<REETYO_FAUCET>(0x2::coin::mint<REETYO_FAUCET>(arg0, arg1, arg3)));
    }

    // decompiled from Move bytecode v6
}

