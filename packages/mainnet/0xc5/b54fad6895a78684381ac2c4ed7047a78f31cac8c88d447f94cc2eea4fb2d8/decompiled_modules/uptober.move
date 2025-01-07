module 0xc5b54fad6895a78684381ac2c4ed7047a78f31cac8c88d447f94cc2eea4fb2d8::uptober {
    struct UPTOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPTOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPTOBER>(arg0, 6, b"UPTOBER", b"Uptober", x"5570746f62657220697320636f6d696e6720736f6f6e205570746f626572206973207472656e64696e67206f6e207820616e642065766572797768657265200a0a73656e64206974", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6282_76aace9e9d.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPTOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPTOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

