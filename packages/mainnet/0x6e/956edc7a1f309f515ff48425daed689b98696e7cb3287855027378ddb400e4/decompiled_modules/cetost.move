module 0x6e956edc7a1f309f515ff48425daed689b98696e7cb3287855027378ddb400e4::cetost {
    struct CETOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETOST>(arg0, 6, b"CETOST", b"Cetos", b"CETOST - OST in LOST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicznlz7dwotpobu6qlvzca4cggxdalhiqdq44psgwiimxgfe7q36a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CETOST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

