module 0x24af39c4ff659366bdc43a0492c1734f1cff717ee8e20136b44f10728aca65b8::kborrt {
    struct KBORRT has drop {
        dummy_field: bool,
    }

    struct Wallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<KBORRT>,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KBORRT>, arg1: &mut Wallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<KBORRT>(&mut arg1.coin, 0x2::coin::into_balance<KBORRT>(0x2::coin::mint<KBORRT>(arg0, arg2, arg3)));
    }

    public entry fun faucet(arg0: &mut Wallet, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KBORRT>>(0x2::coin::take<KBORRT>(&mut arg0.coin, 5000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: KBORRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KBORRT>(arg0, 18, b"kborrtFaucet", b"MC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KBORRT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KBORRT>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Wallet{
            id   : 0x2::object::new(arg1),
            coin : 0x2::balance::zero<KBORRT>(),
        };
        0x2::transfer::share_object<Wallet>(v2);
    }

    // decompiled from Move bytecode v6
}

