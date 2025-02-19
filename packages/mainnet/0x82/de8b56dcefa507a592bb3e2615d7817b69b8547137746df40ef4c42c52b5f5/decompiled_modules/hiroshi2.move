module 0x82de8b56dcefa507a592bb3e2615d7817b69b8547137746df40ef4c42c52b5f5::hiroshi2 {
    struct HIROSHI2 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HIROSHI2>, arg1: 0x2::coin::Coin<HIROSHI2>) {
        0x2::coin::burn<HIROSHI2>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HIROSHI2>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HIROSHI2>>(0x2::coin::mint<HIROSHI2>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HIROSHI2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIROSHI2>(arg0, 2, b"HIROSHI2", b"HIROSHI2", b"Not Reaching !!", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIROSHI2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIROSHI2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

