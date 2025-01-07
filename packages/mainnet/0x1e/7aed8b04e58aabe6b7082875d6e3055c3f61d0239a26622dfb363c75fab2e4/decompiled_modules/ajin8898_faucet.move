module 0x1e7aed8b04e58aabe6b7082875d6e3055c3f61d0239a26622dfb363c75fab2e4::ajin8898_faucet {
    struct AJIN8898_FAUCET has drop {
        dummy_field: bool,
    }

    struct PublicWallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<AJIN8898_FAUCET>,
        faucet_amount: u64,
    }

    public entry fun get_faucet(arg0: &mut PublicWallet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<AJIN8898_FAUCET>(&arg0.coin) >= arg0.faucet_amount, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AJIN8898_FAUCET>>(0x2::coin::from_balance<AJIN8898_FAUCET>(0x2::balance::split<AJIN8898_FAUCET>(&mut arg0.coin, arg0.faucet_amount), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: AJIN8898_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AJIN8898_FAUCET>(arg0, 10, b"ajin8898 Faucet", b"ajin8898 Faucet coin", b"Get some free", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AJIN8898_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AJIN8898_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = PublicWallet{
            id            : 0x2::object::new(arg1),
            coin          : 0x2::balance::zero<AJIN8898_FAUCET>(),
            faucet_amount : 6,
        };
        0x2::transfer::share_object<PublicWallet>(v2);
    }

    public entry fun mint_faucet(arg0: &mut 0x2::coin::TreasuryCap<AJIN8898_FAUCET>, arg1: u64, arg2: &mut PublicWallet, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<AJIN8898_FAUCET>(&mut arg2.coin, 0x2::coin::into_balance<AJIN8898_FAUCET>(0x2::coin::mint<AJIN8898_FAUCET>(arg0, arg1, arg3)));
    }

    // decompiled from Move bytecode v6
}

