module 0x95490c645fad6b243411f642a50af112f8ee9c9041d0e85866cb37ccb1aeb660::yunJudefaucet {
    struct YUNJUDEFAUCET has drop {
        dummy_field: bool,
    }

    struct Wallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<YUNJUDEFAUCET>,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YUNJUDEFAUCET>, arg1: &mut Wallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<YUNJUDEFAUCET>(&mut arg1.coin, 0x2::coin::into_balance<YUNJUDEFAUCET>(0x2::coin::mint<YUNJUDEFAUCET>(arg0, arg2, arg3)));
    }

    public entry fun faucet(arg0: &mut Wallet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YUNJUDEFAUCET>>(0x2::coin::take<YUNJUDEFAUCET>(&mut arg0.coin, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: YUNJUDEFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUNJUDEFAUCET>(arg0, 6, b"YUNJUDEFAUCET", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUNJUDEFAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUNJUDEFAUCET>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Wallet{
            id   : 0x2::object::new(arg1),
            coin : 0x2::balance::zero<YUNJUDEFAUCET>(),
        };
        0x2::transfer::share_object<Wallet>(v2);
    }

    // decompiled from Move bytecode v6
}

