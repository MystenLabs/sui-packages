module 0x79dab87bd956f4e9b6536cdb2483e908a9f58d230df2dde8afff9d7ec1fb825d::FCOIN {
    struct FCOIN has drop {
        dummy_field: bool,
    }

    struct Wallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<FCOIN>,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FCOIN>, arg1: &mut Wallet, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<FCOIN>(&mut arg1.coin, 0x2::coin::into_balance<FCOIN>(0x2::coin::mint<FCOIN>(arg0, 1000000, arg3)));
    }

    public entry fun faucet(arg0: &mut Wallet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FCOIN>>(0x2::coin::take<FCOIN>(&mut arg0.coin, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: FCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCOIN>(arg0, 6, b"FCOIN", b"FC", b"faucet coin for test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCOIN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Wallet{
            id   : 0x2::object::new(arg1),
            coin : 0x2::balance::zero<FCOIN>(),
        };
        0x2::transfer::share_object<Wallet>(v2);
    }

    // decompiled from Move bytecode v6
}

