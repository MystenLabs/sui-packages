module 0x5beaf9e078c2c35f04d6271ece5bcb6cb54e4eae7fde3616a5d2f0f7beec30d::woodwhale {
    struct WOODWHALE has drop {
        dummy_field: bool,
    }

    struct Wallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<WOODWHALE>,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WOODWHALE>, arg1: &mut Wallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<WOODWHALE>(&mut arg1.coin, 0x2::coin::into_balance<WOODWHALE>(0x2::coin::mint<WOODWHALE>(arg0, arg2, arg3)));
    }

    public entry fun faucet(arg0: &mut Wallet, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WOODWHALE>>(0x2::coin::take<WOODWHALE>(&mut arg0.coin, 5000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: WOODWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOODWHALE>(arg0, 6, b"WOOD", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOODWHALE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOODWHALE>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Wallet{
            id   : 0x2::object::new(arg1),
            coin : 0x2::balance::zero<WOODWHALE>(),
        };
        0x2::transfer::share_object<Wallet>(v2);
    }

    // decompiled from Move bytecode v6
}

