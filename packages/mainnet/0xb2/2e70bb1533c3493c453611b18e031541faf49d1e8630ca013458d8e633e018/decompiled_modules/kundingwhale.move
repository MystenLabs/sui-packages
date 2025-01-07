module 0xb22e70bb1533c3493c453611b18e031541faf49d1e8630ca013458d8e633e018::kundingwhale {
    struct KUNDINGWHALE has drop {
        dummy_field: bool,
    }

    struct Wallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<KUNDINGWHALE>,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KUNDINGWHALE>, arg1: &mut Wallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<KUNDINGWHALE>(&mut arg1.coin, 0x2::coin::into_balance<KUNDINGWHALE>(0x2::coin::mint<KUNDINGWHALE>(arg0, arg2, arg3)));
    }

    public entry fun faucet(arg0: &mut Wallet, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KUNDINGWHALE>>(0x2::coin::take<KUNDINGWHALE>(&mut arg0.coin, 5000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: KUNDINGWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUNDINGWHALE>(arg0, 6, b"WOOD", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUNDINGWHALE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUNDINGWHALE>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Wallet{
            id   : 0x2::object::new(arg1),
            coin : 0x2::balance::zero<KUNDINGWHALE>(),
        };
        0x2::transfer::share_object<Wallet>(v2);
    }

    // decompiled from Move bytecode v6
}

