module 0x468c1d31fba1cff3ef8217a1c1a6832468f90fb6d566544637664c6d98029916::dontbuy {
    struct DONTBUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONTBUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONTBUY>(arg0, 6, b"DONTBUYTEST", b"DONTBUY", b"Welcome To Test Me", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DONTBUY>(&mut v2, 80000000000000, @0xa1e5eb06bb08620f23dc1132b997d3a492e6660c12fc4856d17847455aed0d7f, arg1);
        0x2::coin::mint_and_transfer<DONTBUY>(&mut v2, 20000000000000, @0xa1e5eb06bb08620f23dc1132b997d3a492e6660c12fc4856d17847455aed0d7f, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONTBUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONTBUY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

