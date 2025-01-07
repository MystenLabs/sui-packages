module 0xc94a6fb4d6ff6c8a873ec5fea61cb4529165e21bfbfb7bbcaacdeb1d47e6a47f::scai {
    struct SCAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAI>(arg0, 9, b"SCAI", b"SynthCode AI", x"53796e7468436f646520414920697320796f757220756c74696d61746520636f64696e6720636f6d70616e696f6e2c207475726e696e6720696465617320696e746f2066756e6374696f6e616c20636f6465207769746820707265636973696f6e20616e642073706565642e20466561747572696e67206e61747572616c206c616e67756167652d746f2d636f6465207472616e736c6174696f6e2c20696e74656c6c6967656e7420646562756767696e672c20616e64206d756c74692d6c616e677561676520737570706f72742c206974e2809973207065726665637420666f7220626567696e6e65727320616e642070726f7320616c696b652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWFnESAurag65GiBTibkyGqn8RhqiDoEYUix4vZZn5xqu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

