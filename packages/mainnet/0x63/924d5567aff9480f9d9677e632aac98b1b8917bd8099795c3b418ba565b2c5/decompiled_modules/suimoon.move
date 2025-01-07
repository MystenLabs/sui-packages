module 0x63924d5567aff9480f9d9677e632aac98b1b8917bd8099795c3b418ba565b2c5::suimoon {
    struct SUIMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOON>(arg0, 9, b"SMOON", b"SuiMoon", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMOON>(&mut v2, 100000000000000000, @0x44ccc6a7d51b0145383a59ab06d3002890e55a3733e40ac505617601e42e6f4c, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

