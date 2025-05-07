module 0xaa4e4564ec0f00b6a619d8b7baf300567be58811c81c78f5f2f944dc61393434::suiguy {
    struct SUIGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUY>(arg0, 6, b"SuiGuy", b"THE REAL SUI GUY", x"576520617265207265616c20616e642072656d656d6265722074686520747275746820616c7761797320636f6d6573206f75742e0a57656c636f6d6520746f20746865206e657720476f64206f6620537569204d656d6573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiblwfbwdy5n4s4kohfpv4nwjovy7qfaq3aadrodp6mpd42iaw6woi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

