module 0xb5a23e893c8e7b60c45f6b1b232fce1d4a9a4ba2508290d550de54f23b3243d8::feast {
    struct FEAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEAST>(arg0, 6, b"FEAST", b"Chinese Food", x"546865204368696e657365205368616c6c204645415354206f6e207468656972204368696e65736520666f6f640a68747470733a2f2f782e636f6d2f4368696e657365666f6f647375690a68747470733a2f2f742e6d652f4368696e657365666f6f646f6e53554920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_1_8460730e6a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

