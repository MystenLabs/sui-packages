module 0x683bcf2aaa263912d9f1afd2c6c4012c74b58168a2ec7d009c90e34920164e5e::dunno {
    struct DUNNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUNNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUNNO>(arg0, 6, b"DUNNO", b"DUNNO MEME", x"2444554e4e4f2077696c6c206272696e67696e67206d656d6573206261636b20746f20746865697220726f6f7473202121200a4c65742773206272696e67206261636b2077686174206d656d6573207765726520616c77617973206d65616e7420746f20626520756e66696c7465726564206a6f792c20636f6d6d756e69747920616e6420636f6e6e656374696f6e7320212120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DUNNO_47c8012d96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUNNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUNNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

