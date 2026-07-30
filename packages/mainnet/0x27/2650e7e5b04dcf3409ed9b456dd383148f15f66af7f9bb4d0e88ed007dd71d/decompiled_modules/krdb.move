module 0x272650e7e5b04dcf3409ed9b456dd383148f15f66af7f9bb4d0e88ed007dd71d::krdb {
    struct KRDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRDB>(arg0, 9, b"KRDB", x"e99fa9e58583", b"A token created with Sui Token Creator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreiamgz2g3jedcvobmuu4xzwki47h3fd6zahiudvcwqxgzhrtfzabni")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<KRDB>>(0x2::coin::mint<KRDB>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRDB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRDB>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

