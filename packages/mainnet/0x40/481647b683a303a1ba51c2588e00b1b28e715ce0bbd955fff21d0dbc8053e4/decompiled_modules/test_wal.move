module 0x40481647b683a303a1ba51c2588e00b1b28e715ce0bbd955fff21d0dbc8053e4::test_wal {
    struct TEST_WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_WAL>(arg0, 9, b"tWAL", b"Test WAL", 0x1::vector::empty<u8>(), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"NONE")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST_WAL>(&mut v2, 1000000000000000000, @0xa902504c338e17f44dfee1bd1c3cad1ff03326579b9cdcfe2762fc12c46fc033, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_WAL>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST_WAL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

