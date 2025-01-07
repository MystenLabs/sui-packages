module 0x4baaeb6b4f64c7b989f22781309cd9b31fc1b1b3e44395c8b435027d79ef1b14::rzx_faucet_coin {
    struct RZX_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct Wallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<RZX_FAUCET_COIN>,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RZX_FAUCET_COIN>, arg1: &mut Wallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<RZX_FAUCET_COIN>(&mut arg1.coin, 0x2::coin::into_balance<RZX_FAUCET_COIN>(0x2::coin::mint<RZX_FAUCET_COIN>(arg0, arg2, arg3)));
    }

    public entry fun faucet(arg0: &mut Wallet, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RZX_FAUCET_COIN>>(0x2::coin::take<RZX_FAUCET_COIN>(&mut arg0.coin, 10000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: RZX_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RZX_FAUCET_COIN>(arg0, 2, b"RZX-sym", b"RZX-name", b"RZX-desp", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RZX_FAUCET_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RZX_FAUCET_COIN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Wallet{
            id   : 0x2::object::new(arg1),
            coin : 0x2::balance::zero<RZX_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Wallet>(v2);
    }

    // decompiled from Move bytecode v6
}

