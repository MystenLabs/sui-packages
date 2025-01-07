module 0x5e281293c2fd4debdb6bfb92553c28b0b48ec9ecc1955e4aeb599c9e3e16d671::huisqcoin {
    struct HUISQCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HUISQCOIN>, arg1: 0x2::coin::Coin<HUISQCOIN>) {
        0x2::coin::burn<HUISQCOIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HUISQCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HUISQCOIN>>(0x2::coin::mint<HUISQCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HUISQCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUISQCOIN>(arg0, 6, b"HUISQCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUISQCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUISQCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

