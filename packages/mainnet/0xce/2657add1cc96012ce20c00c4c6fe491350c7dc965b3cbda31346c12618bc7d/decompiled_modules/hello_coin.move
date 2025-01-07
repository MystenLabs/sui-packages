module 0xce2657add1cc96012ce20c00c4c6fe491350c7dc965b3cbda31346c12618bc7d::hello_coin {
    struct HELLO_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HELLO_COIN>, arg1: 0x2::coin::Coin<HELLO_COIN>) {
        0x2::coin::burn<HELLO_COIN>(arg0, arg1);
    }

    fun init(arg0: HELLO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO_COIN>(arg0, 9, b"HELLO", b"Hello Coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLO_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HELLO_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HELLO_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

