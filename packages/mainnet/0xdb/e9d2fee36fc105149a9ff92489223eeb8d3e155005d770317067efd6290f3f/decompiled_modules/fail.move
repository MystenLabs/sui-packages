module 0xdbe9d2fee36fc105149a9ff92489223eeb8d3e155005d770317067efd6290f3f::fail {
    struct FAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAIL>(arg0, 6, b"FAIL", b"FAILURE", b"I'm a failure, i failed in my career, I'm  in now in the trenches making it big and living large.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicy4v7rxa5xgqj3bb3yufzm664kj6g7c2ofv5fdiraovjzu75dbgi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FAIL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

