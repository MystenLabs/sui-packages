module 0xd9c9c49e9ea667689797bbde157f85113c97c375fdb0198132c4624073114256::zzf222_coin {
    struct ZZF222_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZZF222_COIN>, arg1: 0x2::coin::Coin<ZZF222_COIN>) {
        0x2::coin::burn<ZZF222_COIN>(arg0, arg1);
    }

    fun init(arg0: ZZF222_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZF222_COIN>(arg0, 2, b"MY_COIN", b"MC", b"just finish task2", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZZF222_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZF222_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZZF222_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZZF222_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

