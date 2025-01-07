module 0x8eb7022eeb46e79643dface316537b257293fdd5989ad814d3e1b8f2844d6a07::redrocket {
    struct REDROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDROCKET>(arg0, 6, b"REDROCKET", b"Red Rocket Dog", x"5468652043756d20526f636b6574206f662053756921200a4e6f20736f6369616c7320637265617465642c206665656c206672656520746f20646f20736f20616e64206c657473206275696c64206120636f6d6d756e69747920746f6765746865722c2077696c6c206265206a6f696e696e6720696e206f6e636520746865726573206120636f6d6d756e69747920616e642070617920666f722064657820616e64206164733a29", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7267_dac603de68.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDROCKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDROCKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

