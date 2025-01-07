module 0x5fa7b3254cf9f8b9009369315180c5fb0ec5154025c75fc8bd67559b1def10e7::musk {
    struct MUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSK>(arg0, 6, b"MUSK", b"musk", b"MuskCoin is inspired by one of the most incredible engineers of the modern world -Elon Musk. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000384_ff0c324a4d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

