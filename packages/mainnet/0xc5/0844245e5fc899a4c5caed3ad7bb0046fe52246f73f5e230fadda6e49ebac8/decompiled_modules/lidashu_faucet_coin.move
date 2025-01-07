module 0xc50844245e5fc899a4c5caed3ad7bb0046fe52246f73f5e230fadda6e49ebac8::lidashu_faucet_coin {
    struct LIDASHU_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LIDASHU_FAUCET_COIN>, arg1: 0x2::coin::Coin<LIDASHU_FAUCET_COIN>) {
        0x2::coin::burn<LIDASHU_FAUCET_COIN>(arg0, arg1);
    }

    public entry fun faucet(arg0: &mut 0x2::coin::TreasuryCap<LIDASHU_FAUCET_COIN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LIDASHU_FAUCET_COIN>(arg0, 1000000, 0x2::tx_context::sender(arg1), arg1);
    }

    fun init(arg0: LIDASHU_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIDASHU_FAUCET_COIN>(arg0, 6, b"LDSF", b"LIDASHU faucet coin", b"LDSF mint for all", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIDASHU_FAUCET_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIDASHU_FAUCET_COIN>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LIDASHU_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LIDASHU_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

