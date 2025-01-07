module 0x729ac581cb5f51ae8c7b66220525310ad8ed417ef54d92fd11e2ec40b1ac9d82::capy_faucet {
    struct CAPY_FAUCET has drop {
        dummy_field: bool,
    }

    struct PublicWallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<CAPY_FAUCET>,
        faucet_amount: u64,
    }

    public entry fun get_faucet(arg0: &mut PublicWallet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<CAPY_FAUCET>(&arg0.coin) >= arg0.faucet_amount, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CAPY_FAUCET>>(0x2::coin::from_balance<CAPY_FAUCET>(0x2::balance::split<CAPY_FAUCET>(&mut arg0.coin, arg0.faucet_amount), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: CAPY_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPY_FAUCET>(arg0, 10, b"CAPY Faucet", b"CAPY Faucet", b"Get some free coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPY_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPY_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = PublicWallet{
            id            : 0x2::object::new(arg1),
            coin          : 0x2::balance::zero<CAPY_FAUCET>(),
            faucet_amount : 6,
        };
        0x2::transfer::share_object<PublicWallet>(v2);
    }

    public entry fun mint_faucet(arg0: &mut 0x2::coin::TreasuryCap<CAPY_FAUCET>, arg1: u64, arg2: &mut PublicWallet, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<CAPY_FAUCET>(&mut arg2.coin, 0x2::coin::into_balance<CAPY_FAUCET>(0x2::coin::mint<CAPY_FAUCET>(arg0, arg1, arg3)));
    }

    // decompiled from Move bytecode v6
}

