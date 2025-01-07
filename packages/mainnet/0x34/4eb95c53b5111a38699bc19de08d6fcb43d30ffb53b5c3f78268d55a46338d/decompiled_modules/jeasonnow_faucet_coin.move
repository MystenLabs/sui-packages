module 0x344eb95c53b5111a38699bc19de08d6fcb43d30ffb53b5c3f78268d55a46338d::jeasonnow_faucet_coin {
    struct JEASONNOW_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct Wallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<JEASONNOW_FAUCET_COIN>,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JEASONNOW_FAUCET_COIN>, arg1: &mut Wallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<JEASONNOW_FAUCET_COIN>(&mut arg1.coin, 0x2::coin::into_balance<JEASONNOW_FAUCET_COIN>(0x2::coin::mint<JEASONNOW_FAUCET_COIN>(arg0, arg2, arg3)));
    }

    public entry fun faucet(arg0: &mut Wallet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JEASONNOW_FAUCET_COIN>>(0x2::coin::take<JEASONNOW_FAUCET_COIN>(&mut arg0.coin, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: JEASONNOW_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEASONNOW_FAUCET_COIN>(arg0, 6, b"JFC", b"JeasonnowFaucetCoin", b"Jeasonnow Faucet Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEASONNOW_FAUCET_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEASONNOW_FAUCET_COIN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Wallet{
            id   : 0x2::object::new(arg1),
            coin : 0x2::balance::zero<JEASONNOW_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Wallet>(v2);
    }

    // decompiled from Move bytecode v6
}

