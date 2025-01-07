module 0xa3edb15cb5cf85ddbe5bb2b5fb9ff0cad03de43f8a017fb7f0513844df769b80::up {
    struct UP has drop {
        dummy_field: bool,
    }

    fun init(arg0: UP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UP>(arg0, 6, b"UP", b"Up Only", x"646f6e2774206d6973732069742062726f2c207765277265206a75737420676f696e6720746f2074686520746f700a77652077696c6c206275696c6420746f6765746865722061207374726f6e6720636f6d6d756e697479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031300_9c5b5f796d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UP>>(v1);
    }

    // decompiled from Move bytecode v6
}

