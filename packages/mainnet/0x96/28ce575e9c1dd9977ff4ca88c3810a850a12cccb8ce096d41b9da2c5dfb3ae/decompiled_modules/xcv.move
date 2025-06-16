module 0x9628ce575e9c1dd9977ff4ca88c3810a850a12cccb8ce096d41b9da2c5dfb3ae::xcv {
    struct XCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: XCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XCV>(arg0, 6, b"XCV", b"xcvcx", b"asdxcv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidch4l57vqqykhp6ydcqjlmadjpcsyn7dws6bbbpfrqnxjoqmeelu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XCV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XCV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

