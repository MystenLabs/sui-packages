module 0xc3d65ee2c386f0912d1914f43466d02952010e030b3e95ae08c7be473bc88e65::unidog {
    struct UNIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIDOG>(arg0, 6, b"UNIDOG", b"Uni.the.Wonder.Dog", x"496d206f6e65206c75636b7920646f672120496d20556e692e7468652e576f6e6465722e446f672e204d792066616d696c792072657363756564206d65206261636b20696e204a616e7561727920323031342e204e6f7720492067657420746f20656174206170706c6573206576657279206461792e204a616e75617279203131206973206d7920616e6e69766572736172792e0a245574772e446f672c206e6f20636f6d6d756e6974792c206e6f20582c206e6f206f6666696369616c20776562736974652c2074686520646563656e7472616c697a656420746f6b656e206f66207468652070656f706c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008849_f48dfa690f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

