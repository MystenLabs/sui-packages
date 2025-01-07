module 0xeb49e5c1d5d5b0fb638945001c1e711a7aaa6943f560a5a2c3112d795f0bddf6::vapor {
    struct VAPOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAPOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAPOR>(arg0, 6, b"VAPOR", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAPOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<VAPOR>>(0x2::coin::mint<VAPOR>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAPOR>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

