module 0xcc393d9b70f104f9f30502c65e501b294c165d70fd647551a483377ad76eed74::yellow {
    struct YELLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: YELLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YELLOW>(arg0, 6, b"YELLOW", b"YELLOW FIN", x"2459454c4c4f57207c20426c756566696e2076732059656c6c6f7766696e207c205574696c6974696573207673204d656d65732e200a536f2c207768617420646f20796f752063686f6f73653f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000088010_6878ddb5d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YELLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YELLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

