module 0x36b08d9d4653a30bb01177d04d32c39ba1eadf1d5b88ab201a2ecadb1ff36463::faucet_coin {
    struct FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct FaucetCoin has store, key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<FAUCET_COIN>,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: &mut FaucetCoin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<FAUCET_COIN>(&mut arg1.coin, 0x2::coin::into_balance<FAUCET_COIN>(0x2::coin::mint<FAUCET_COIN>(arg0, arg2, arg3)));
    }

    public entry fun faucet(arg0: &mut FaucetCoin, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCET_COIN>>(0x2::coin::take<FAUCET_COIN>(&mut arg0.coin, 10000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_COIN>(arg0, 6, b"AKAKing", b"AKAKing", b"AKAKing", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAUCET_COIN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = FaucetCoin{
            id   : 0x2::object::new(arg1),
            coin : 0x2::balance::zero<FAUCET_COIN>(),
        };
        0x2::transfer::public_share_object<FaucetCoin>(v2);
    }

    // decompiled from Move bytecode v6
}

