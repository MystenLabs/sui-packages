module 0x436a7fd1d8b26c6b114986d35b46bea1234e1464af08be62ba2d4d8e2ee7c2c1::satoshi {
    struct SATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSHI>(arg0, 9, b"SATOSHI", b"Official Satoshi Coin", x"245341544f534849202d20546865206f6e6c79206f6666696369616c205361746f73686920636f696e206d656d652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUNMd9Rg9RM76g8MBvub8z7tSW5GzG6D8vj27m5F7N6XX")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SATOSHI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATOSHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

