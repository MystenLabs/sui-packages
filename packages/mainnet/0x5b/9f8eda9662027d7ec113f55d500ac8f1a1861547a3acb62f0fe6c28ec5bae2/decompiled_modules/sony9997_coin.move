module 0x5b9f8eda9662027d7ec113f55d500ac8f1a1861547a3acb62f0fe6c28ec5bae2::sony9997_coin {
    struct SONY9997_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SONY9997_COIN>, arg1: 0x2::coin::Coin<SONY9997_COIN>) {
        0x2::coin::burn<SONY9997_COIN>(arg0, arg1);
    }

    fun init(arg0: SONY9997_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONY9997_COIN>(arg0, 6, b"SONY9997_COIN", b"S9C", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SONY9997_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONY9997_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SONY9997_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SONY9997_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

