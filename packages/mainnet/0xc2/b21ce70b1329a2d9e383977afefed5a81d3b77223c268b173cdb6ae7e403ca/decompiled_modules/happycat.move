module 0xc2b21ce70b1329a2d9e383977afefed5a81d3b77223c268b173cdb6ae7e403ca::happycat {
    struct HAPPYCAT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HAPPYCAT>, arg1: 0x2::coin::Coin<HAPPYCAT>) {
        0x2::coin::burn<HAPPYCAT>(arg0, arg1);
    }

    fun init(arg0: HAPPYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HAPPYCAT>(arg0, 6, b"HAPPYCAT", b"Happy Cat", b"happy happy happy~ happy happy happy~ This is a happy song", 0x1::option::none<0x2::url::Url>(), false, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HAPPYCAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAPPYCAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HAPPYCAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HAPPYCAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

