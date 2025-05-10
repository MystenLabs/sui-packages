module 0x30ed2531a129bbf74e9e300cf4c40c738f7a752ab7af8a6498c73367f99713bd::tardi {
    struct TARDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARDI>(arg0, 6, b"TARDI", b"Tardi Moon", x"496d20746865204f47204d6f6f6e626f79202f20696e646573747275637469626c65206d6963726f73636f70696320776174657220626561722e200a0a535549277320546f75676865737420546f6b656e2028536369656e7469666963616c6c792050726f76656e292e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000068437_a6e59f0953.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TARDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

