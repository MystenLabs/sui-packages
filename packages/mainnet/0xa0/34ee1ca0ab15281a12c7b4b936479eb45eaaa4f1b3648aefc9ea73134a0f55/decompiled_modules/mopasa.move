module 0xa034ee1ca0ab15281a12c7b4b936479eb45eaaa4f1b3648aefc9ea73134a0f55::mopasa {
    struct MOPASA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOPASA>, arg1: 0x2::coin::Coin<MOPASA>) {
        0x2::coin::burn<MOPASA>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOPASA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOPASA>>(0x2::coin::mint<MOPASA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOPASA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOPASA>(arg0, 9, b"mopasa", b"MOPASA", b"test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOPASA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOPASA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

