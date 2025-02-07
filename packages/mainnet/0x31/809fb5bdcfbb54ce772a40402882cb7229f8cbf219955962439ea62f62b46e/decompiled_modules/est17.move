module 0x31809fb5bdcfbb54ce772a40402882cb7229f8cbf219955962439ea62f62b46e::est17 {
    struct EST17 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EST17, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EST17>(arg0, 6, b"EST17", b"testing", b"sdfasd asd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1738927647313-upload.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EST17>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EST17>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

