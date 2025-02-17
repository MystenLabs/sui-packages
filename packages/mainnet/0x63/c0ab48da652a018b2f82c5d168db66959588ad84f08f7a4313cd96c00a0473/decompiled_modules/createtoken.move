module 0x63c0ab48da652a018b2f82c5d168db66959588ad84f08f7a4313cd96c00a0473::createtoken {
    struct CREATETOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREATETOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREATETOKEN>(arg0, 6, b"CREATETOKEN", b"Create Token Test", b"Template Coin Description4", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREATETOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CREATETOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

