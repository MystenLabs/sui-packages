module 0x2d0f3b1a79515de1d36ed3dd5ab642396f78871f57b46a3d6f5e3e73afda27d9::tsts {
    struct TSTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTS>(arg0, 6, b"TSTS", b"TST2", b"onetwothree", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaucvqycegjjxxjt5i5aki22e6g6zw5qd4igz5u5ul5ndciqj4diq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSTS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

