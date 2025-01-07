module 0x1d4ba100d6d12931bb4aedc45f6643b485fd55b6a339b9fbcc43399e8cc67aa::CodingGeoff_faucet {
    struct CODINGGEOFF_FAUCET has drop {
        dummy_field: bool,
    }

    struct PublicWallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<CODINGGEOFF_FAUCET>,
        faucet_amount: u64,
    }

    public entry fun get_faucet(arg0: &mut PublicWallet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<CODINGGEOFF_FAUCET>(&arg0.coin) >= arg0.faucet_amount, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CODINGGEOFF_FAUCET>>(0x2::coin::from_balance<CODINGGEOFF_FAUCET>(0x2::balance::split<CODINGGEOFF_FAUCET>(&mut arg0.coin, arg0.faucet_amount), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: CODINGGEOFF_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CODINGGEOFF_FAUCET>(arg0, 10, b"CodingGeoff Faucet", b"CodingGeoff Faucet", b"Get some free coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CODINGGEOFF_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CODINGGEOFF_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = PublicWallet{
            id            : 0x2::object::new(arg1),
            coin          : 0x2::balance::zero<CODINGGEOFF_FAUCET>(),
            faucet_amount : 6,
        };
        0x2::transfer::share_object<PublicWallet>(v2);
    }

    public entry fun mint_faucet(arg0: &mut 0x2::coin::TreasuryCap<CODINGGEOFF_FAUCET>, arg1: u64, arg2: &mut PublicWallet, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<CODINGGEOFF_FAUCET>(&mut arg2.coin, 0x2::coin::into_balance<CODINGGEOFF_FAUCET>(0x2::coin::mint<CODINGGEOFF_FAUCET>(arg0, arg1, arg3)));
    }

    // decompiled from Move bytecode v6
}

