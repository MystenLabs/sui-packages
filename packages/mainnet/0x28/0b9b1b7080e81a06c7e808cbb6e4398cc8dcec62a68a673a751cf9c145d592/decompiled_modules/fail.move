module 0x280b9b1b7080e81a06c7e808cbb6e4398cc8dcec62a68a673a751cf9c145d592::fail {
    struct FAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAIL>(arg0, 6, b"FAIL", b"FAILURE", b"I'm a failure, I failed in my career, now I'm in trenches and making it rich.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicy4v7rxa5xgqj3bb3yufzm664kj6g7c2ofv5fdiraovjzu75dbgi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FAIL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

