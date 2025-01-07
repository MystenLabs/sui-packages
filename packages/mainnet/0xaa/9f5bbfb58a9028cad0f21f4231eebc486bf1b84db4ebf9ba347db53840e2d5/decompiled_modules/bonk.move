module 0xaa9f5bbfb58a9028cad0f21f4231eebc486bf1b84db4ebf9ba347db53840e2d5::bonk {
    struct BONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONK>(arg0, 5, b"BONK", b"Wrapped Coin for Bonk", b"Sudo Wrapped Coin for Bonk", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONK>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BONK>>(v0);
    }

    // decompiled from Move bytecode v6
}

