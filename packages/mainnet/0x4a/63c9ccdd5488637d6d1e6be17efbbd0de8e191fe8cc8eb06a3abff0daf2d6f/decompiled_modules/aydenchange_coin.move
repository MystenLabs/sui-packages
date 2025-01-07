module 0x4a63c9ccdd5488637d6d1e6be17efbbd0de8e191fe8cc8eb06a3abff0daf2d6f::aydenchange_coin {
    struct AYDENCHANGE_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn<T0>(arg0: &mut 0x2::coin::TreasuryCap<AYDENCHANGE_COIN>, arg1: 0x2::coin::Coin<AYDENCHANGE_COIN>) {
        0x2::coin::burn<AYDENCHANGE_COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AYDENCHANGE_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AYDENCHANGE_COIN>>(0x2::coin::mint<AYDENCHANGE_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AYDENCHANGE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYDENCHANGE_COIN>(arg0, 6, b"AYDENCHANGE_COIN", b"AYDENCHANGE_COIN", b"this is aydenchange_coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AYDENCHANGE_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYDENCHANGE_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

