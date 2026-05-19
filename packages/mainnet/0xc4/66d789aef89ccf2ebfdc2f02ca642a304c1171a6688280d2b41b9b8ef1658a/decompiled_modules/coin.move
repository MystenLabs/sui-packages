module 0xc466d789aef89ccf2ebfdc2f02ca642a304c1171a6688280d2b41b9b8ef1658a::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 9, b"FY", b"Feiying", x"46656979696e67205370656369616c20456d62726f696465727920697320616e20696e746567726174656420656e746572707269736520636f766572696e6720646576656c6f706d656e742c2064657369676e2c2070726f64756374696f6e2c2073616c657320616e6420736572766963652e20576520666f637573206f6e20636f6d7075746572697a656420656d62726f696465727920616e642068616e646372616674656420656d62726f696465727920637573746f6d697a6174696f6e20666f72206170706172656c2c20686174732c206261677320616e64206272616e646564206d65726368616e646973652e0a0a0a576562736974653a2068747470733a2f2f6f7870702e636f6d2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://oxpp.com/feiying-logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN>>(0x2::coin::mint<COIN>(&mut v2, 15000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

