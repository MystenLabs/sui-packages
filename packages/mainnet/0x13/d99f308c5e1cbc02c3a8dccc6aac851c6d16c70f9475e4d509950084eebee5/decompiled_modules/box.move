module 0x13d99f308c5e1cbc02c3a8dccc6aac851c6d16c70f9475e4d509950084eebee5::box {
    struct BOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOX>(arg0, 9, b"BOX", b"Box", b"This is box", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:4566/local/images/wave-pumps/b75ab657-a400-4980-b787-9d9213ac13f9-box.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

