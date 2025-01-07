module 0xc3c75abbac50134ca52cb4ca8e0ac663c57257340487dea11401189ea0b00e2e::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOF>(arg0, 6, b"WOOF", b"dog in a cats world", x"466f7220746f6f206c6f6e672c20746865206361747320686176652074616b656e20636f6e74726f6c2e205468657265206861732079657420746f206265206120646f6720776869636820726570726573656e7473207468652077617220616761696e737420636174732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/header_02_d0b69c4c28.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

