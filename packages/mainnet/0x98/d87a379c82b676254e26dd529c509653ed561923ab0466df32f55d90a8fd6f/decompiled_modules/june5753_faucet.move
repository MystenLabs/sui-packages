module 0x98d87a379c82b676254e26dd529c509653ed561923ab0466df32f55d90a8fd6f::june5753_faucet {
    struct JUNE5753_FAUCET has drop {
        dummy_field: bool,
    }

    struct Wallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<JUNE5753_FAUCET>,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JUNE5753_FAUCET>, arg1: &mut Wallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<JUNE5753_FAUCET>(&mut arg1.coin, 0x2::coin::into_balance<JUNE5753_FAUCET>(0x2::coin::mint<JUNE5753_FAUCET>(arg0, arg2, arg3)));
    }

    public entry fun faucet(arg0: &mut Wallet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JUNE5753_FAUCET>>(0x2::coin::take<JUNE5753_FAUCET>(&mut arg0.coin, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: JUNE5753_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUNE5753_FAUCET>(arg0, 9, b"BRF", b"june5753Faucet", b"June5753 facet is so cool", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUNE5753_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUNE5753_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Wallet{
            id   : 0x2::object::new(arg1),
            coin : 0x2::balance::zero<JUNE5753_FAUCET>(),
        };
        0x2::transfer::share_object<Wallet>(v2);
    }

    // decompiled from Move bytecode v6
}

