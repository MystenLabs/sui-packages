module 0xcc716dac46ebe295b199151267e37d46249f6c59803c63a53d0e1623a87ecc5d::dirtmelon_faucet {
    struct DIRTMELON_FAUCET has drop {
        dummy_field: bool,
    }

    struct PublicWallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<DIRTMELON_FAUCET>,
        faucet_amount: u64,
    }

    public entry fun get_faucet(arg0: &mut PublicWallet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<DIRTMELON_FAUCET>(&arg0.coin) >= arg0.faucet_amount, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DIRTMELON_FAUCET>>(0x2::coin::from_balance<DIRTMELON_FAUCET>(0x2::balance::split<DIRTMELON_FAUCET>(&mut arg0.coin, arg0.faucet_amount), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: DIRTMELON_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIRTMELON_FAUCET>(arg0, 10, b"Dirtmelon Faucet", b"Dirtmelon Faucet", b"Meme Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIRTMELON_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIRTMELON_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = PublicWallet{
            id            : 0x2::object::new(arg1),
            coin          : 0x2::balance::zero<DIRTMELON_FAUCET>(),
            faucet_amount : 6,
        };
        0x2::transfer::share_object<PublicWallet>(v2);
    }

    public entry fun mint_faucet(arg0: &mut 0x2::coin::TreasuryCap<DIRTMELON_FAUCET>, arg1: u64, arg2: &mut PublicWallet, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<DIRTMELON_FAUCET>(&mut arg2.coin, 0x2::coin::into_balance<DIRTMELON_FAUCET>(0x2::coin::mint<DIRTMELON_FAUCET>(arg0, arg1, arg3)));
    }

    // decompiled from Move bytecode v6
}

