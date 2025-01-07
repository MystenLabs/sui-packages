module 0x8056d2e45ac28ea1f5dac32dd072d45744655b1c0072d91f8314a63946ce402f::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    struct Wallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<MYCOIN>,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: &mut Wallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<MYCOIN>(&mut arg1.coin, 0x2::coin::into_balance<MYCOIN>(0x2::coin::mint<MYCOIN>(arg0, arg2, arg3)));
    }

    public entry fun faucet(arg0: &mut Wallet, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(0x2::coin::take<MYCOIN>(&mut arg0.coin, 5000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 6, b"FC", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Wallet{
            id   : 0x2::object::new(arg1),
            coin : 0x2::balance::zero<MYCOIN>(),
        };
        0x2::transfer::share_object<Wallet>(v2);
    }

    // decompiled from Move bytecode v6
}

