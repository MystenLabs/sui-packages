module 0x252d63e084e2f2c7f6828e14239b40aed78336b462d974e00db8d182f68535cb::testtoken {
    struct TESTTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTTOKEN>(arg0, 2, b"TESTTOKEN", b"Test Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTTOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTTOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TESTTOKEN>(arg0, arg1, arg2, arg3);
    }

    public entry fun transferOwnership(arg0: 0x2::coin::TreasuryCap<TESTTOKEN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTOKEN>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

