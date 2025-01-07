module 0x943049e83a4b5e40e6cbbc2c5aeb5a61d29c28bae9a56a08c70ce5427ae59ef::kael777_faucet {
    struct KAEL777_FAUCET has drop {
        dummy_field: bool,
    }

    struct Wallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<KAEL777_FAUCET>,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KAEL777_FAUCET>, arg1: &mut Wallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<KAEL777_FAUCET>(&mut arg1.coin, 0x2::coin::into_balance<KAEL777_FAUCET>(0x2::coin::mint<KAEL777_FAUCET>(arg0, arg2, arg3)));
    }

    public entry fun faucet(arg0: &mut Wallet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KAEL777_FAUCET>>(0x2::coin::take<KAEL777_FAUCET>(&mut arg0.coin, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: KAEL777_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAEL777_FAUCET>(arg0, 6, b"KAEL777FAUCET", b"Kael777FaucetCoin", b"Kael777 Faucet Coin is so cool", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAEL777_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAEL777_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Wallet{
            id   : 0x2::object::new(arg1),
            coin : 0x2::balance::zero<KAEL777_FAUCET>(),
        };
        0x2::transfer::share_object<Wallet>(v2);
    }

    // decompiled from Move bytecode v6
}

