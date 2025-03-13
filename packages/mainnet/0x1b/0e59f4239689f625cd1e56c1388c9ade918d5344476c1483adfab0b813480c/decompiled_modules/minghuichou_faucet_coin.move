module 0x1b0e59f4239689f625cd1e56c1388c9ade918d5344476c1483adfab0b813480c::minghuichou_faucet_coin {
    struct MINGHUICHOU_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MINGHUICHOU_FAUCET_COIN>, arg1: 0x2::coin::Coin<MINGHUICHOU_FAUCET_COIN>) {
        0x2::coin::burn<MINGHUICHOU_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: MINGHUICHOU_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINGHUICHOU_FAUCET_COIN>(arg0, 9, b"CRF", b"MINGHUICHOU_FAUCET_COIN", b"minghuichou Faucet Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/129301868?s=400&v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINGHUICHOU_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MINGHUICHOU_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MINGHUICHOU_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MINGHUICHOU_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

