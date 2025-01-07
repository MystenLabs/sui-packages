module 0x1bb4375bc50d5ff8a2aa01c105fcd643146d29366f7c5cdf9bf019f1e2b44c21::aiqubit_faucet {
    struct AIQUBIT_FAUCET has drop {
        dummy_field: bool,
    }

    struct Wallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<AIQUBIT_FAUCET>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AIQUBIT_FAUCET>, arg1: 0x2::coin::Coin<AIQUBIT_FAUCET>) {
        0x2::coin::burn<AIQUBIT_FAUCET>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIQUBIT_FAUCET>, arg1: u64, arg2: &mut Wallet, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<AIQUBIT_FAUCET>(&mut arg2.coin, 0x2::coin::into_balance<AIQUBIT_FAUCET>(0x2::coin::mint<AIQUBIT_FAUCET>(arg0, arg1, arg3)));
    }

    public entry fun faucet(arg0: &mut Wallet, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AIQUBIT_FAUCET>>(0x2::coin::take<AIQUBIT_FAUCET>(&mut arg0.coin, 1000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: AIQUBIT_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIQUBIT_FAUCET>(arg0, 6, b"AIQF", b"AIQUBIT_FAUCET", b"Don't ask why", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/35585232?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIQUBIT_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIQUBIT_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Wallet>(new_wallet(arg1, 0x2::balance::zero<AIQUBIT_FAUCET>()));
    }

    public fun new_wallet(arg0: &mut 0x2::tx_context::TxContext, arg1: 0x2::balance::Balance<AIQUBIT_FAUCET>) : Wallet {
        Wallet{
            id   : 0x2::object::new(arg0),
            coin : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

