module 0xa53e87279adc5d31d29f15884bf22e2448d667bd2542b500ee861b1759ad5d71::lz1998_coin {
    struct LZ1998_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LZ1998_COIN>, arg1: 0x2::coin::Coin<LZ1998_COIN>) {
        0x2::coin::burn<LZ1998_COIN>(arg0, arg1);
    }

    fun init(arg0: LZ1998_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LZ1998_COIN>(arg0, 6, b"lz1998 COIN", b"lz1998 COIN", b"Amazing Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LZ1998_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LZ1998_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LZ1998_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LZ1998_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

