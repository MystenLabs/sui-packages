module 0x470ee6a037d7d69cb2669ea2aed4d1c6e2be0e17c9fcb175bac8e8b094344f3c::piggy {
    struct PIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGGY>(arg0, 6, b"PIGGY", b"Piggy Coin", x"546865206c6f76656c792070696e6b20656e657267792074686174205069676779206272696e67732077696c6c20656c696d696e617465206a6565746572202121210a24504947475920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avt2_e723ea624c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

