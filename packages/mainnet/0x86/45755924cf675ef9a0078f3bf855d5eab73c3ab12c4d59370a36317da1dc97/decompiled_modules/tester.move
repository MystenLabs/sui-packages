module 0x8645755924cf675ef9a0078f3bf855d5eab73c3ab12c4d59370a36317da1dc97::tester {
    struct TESTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTER>(arg0, 6, b"TESTER", b"DONOTBUY", b"DONOTBUY DONOTBUY DONOTBUY DONOTBUY DONOTBUY DONOTBUY DONOTBUY DONOTBUY DONOTBUY DONOTBUY DONOTBUY DONOTBUY DONOTBUY DONOTBUY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihctbqnyc53gicl2d6wmghulrnpxptqamzmpbnv5uwjrbabuzqmhy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

