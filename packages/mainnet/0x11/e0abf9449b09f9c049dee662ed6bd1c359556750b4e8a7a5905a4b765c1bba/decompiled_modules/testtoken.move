module 0x11e0abf9449b09f9c049dee662ed6bd1c359556750b4e8a7a5905a4b765c1bba::testtoken {
    struct TESTTOKEN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTTOKEN>, arg1: 0x2::coin::Coin<TESTTOKEN>) {
        0x2::coin::burn<TESTTOKEN>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<TESTTOKEN>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTOKEN>>(arg0, @0x0);
    }

    fun init(arg0: TESTTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTTOKEN>(arg0, 6, b"TEST", b"TestToken", b"A test token for deployment", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTTOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTTOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TESTTOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

