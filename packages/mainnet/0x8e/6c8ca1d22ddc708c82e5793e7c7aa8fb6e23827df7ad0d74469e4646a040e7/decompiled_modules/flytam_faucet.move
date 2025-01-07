module 0x8e6c8ca1d22ddc708c82e5793e7c7aa8fb6e23827df7ad0d74469e4646a040e7::flytam_faucet {
    struct FLYTAM_FAUCET has drop {
        dummy_field: bool,
    }

    struct PublicWallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<FLYTAM_FAUCET>,
        faucet_amount: u64,
    }

    public entry fun get_faucet(arg0: &mut PublicWallet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<FLYTAM_FAUCET>(&arg0.coin) >= arg0.faucet_amount, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FLYTAM_FAUCET>>(0x2::coin::from_balance<FLYTAM_FAUCET>(0x2::balance::split<FLYTAM_FAUCET>(&mut arg0.coin, arg0.faucet_amount), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: FLYTAM_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLYTAM_FAUCET>(arg0, 10, b"Flytam Faucet", b"Flytam Faucet", b"Meme Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLYTAM_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLYTAM_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = PublicWallet{
            id            : 0x2::object::new(arg1),
            coin          : 0x2::balance::zero<FLYTAM_FAUCET>(),
            faucet_amount : 6,
        };
        0x2::transfer::share_object<PublicWallet>(v2);
    }

    public entry fun mint_faucet(arg0: &mut 0x2::coin::TreasuryCap<FLYTAM_FAUCET>, arg1: u64, arg2: &mut PublicWallet, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<FLYTAM_FAUCET>(&mut arg2.coin, 0x2::coin::into_balance<FLYTAM_FAUCET>(0x2::coin::mint<FLYTAM_FAUCET>(arg0, arg1, arg3)));
    }

    // decompiled from Move bytecode v6
}

