module 0x6b12abc4ec4300de725323335cc0693ace2d76a210821b48a6ebeeec78621f23::krts {
    struct KRTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRTS>(arg0, 6, b"KRTS", b"KRTEXSUI", b"Hello Krtex! Today is a great day for us to explore interesting things about Suinetwork together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_0185730d7d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

