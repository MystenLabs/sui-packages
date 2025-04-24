module 0x344226b5c3be4486f133f82a101e2f1ec7e3bfa7603ec49449e4d9cbc0164380::suicoffee {
    struct SUICOFFEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICOFFEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOFFEE>(arg0, 6, b"SUICOFFEE", b"sui coffee meme", b"https://x.com/kostascrypto/status/1915456372658893011", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiayo3dl3ndhu2a4bwjjcznvzs37wqvaxalmqgxzsme5cknomvxqiq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOFFEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICOFFEE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

