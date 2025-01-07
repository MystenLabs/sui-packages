module 0xde58bd8642d18edc4b8ae5eb22f2f50bd88fb0edf4da7ef0326a0aacb81ca043::ucoin {
    struct UCOIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<UCOIN>, arg1: 0x2::coin::Coin<UCOIN>) {
        0x2::coin::burn<UCOIN>(arg0, arg1);
    }

    fun init(arg0: UCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UCOIN>(arg0, 2, b"UCOIN", b"UPC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<UCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<UCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

