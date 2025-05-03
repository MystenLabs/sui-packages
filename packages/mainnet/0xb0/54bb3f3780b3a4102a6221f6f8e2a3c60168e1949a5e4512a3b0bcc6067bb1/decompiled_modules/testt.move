module 0xb054bb3f3780b3a4102a6221f6f8e2a3c60168e1949a5e4512a3b0bcc6067bb1::testt {
    struct TESTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTT>(arg0, 6, b"TESTT", b"Test Token", b"Just test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiazk52liuhz6xavp6yaeru3itixon44oquqxdimptf2ifvdyqeg7u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

