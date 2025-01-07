module 0x8e2a73408fca22135ffa18faf6a553738f8b4338486bc6c3b7d38345a8d7b1d9::faucetcoin {
    struct Wallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<FAUCETCOIN>,
    }

    struct FAUCETCOIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCETCOIN>, arg1: &mut Wallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<FAUCETCOIN>(&mut arg1.coin, 0x2::coin::into_balance<FAUCETCOIN>(0x2::coin::mint<FAUCETCOIN>(arg0, arg2, arg3)));
    }

    public entry fun faucet(arg0: &mut Wallet, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCETCOIN>>(0x2::coin::take<FAUCETCOIN>(&mut arg0.coin, 200, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: FAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCETCOIN>(arg0, 6, b"FAUCETCOIN", b"C", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCETCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAUCETCOIN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Wallet{
            id   : 0x2::object::new(arg1),
            coin : 0x2::balance::zero<FAUCETCOIN>(),
        };
        0x2::transfer::share_object<Wallet>(v2);
    }

    // decompiled from Move bytecode v6
}

