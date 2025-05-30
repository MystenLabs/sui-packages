module 0xd9c28826ecc55e19e70dc063af008659a396c38b3f3237e6358b862cb044cf69::dtoken {
    struct DTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTOKEN>(arg0, 6, b"D-Token", b"Token With Dashes", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DTOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

