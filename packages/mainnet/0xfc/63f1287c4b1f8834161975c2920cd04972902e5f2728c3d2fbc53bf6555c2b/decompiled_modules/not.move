module 0xfc63f1287c4b1f8834161975c2920cd04972902e5f2728c3d2fbc53bf6555c2b::not {
    struct NOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOT>(arg0, 6, b"NOT", b"Nothing sui", b"NOTHING !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibbf2yzbbkvuilahaej6qwq3gr3rcxhakybvfwrp5krhk6wplajkq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

