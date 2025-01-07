module 0xc245f2fdca721c1b37b44bf3c82bc60666df11655c8be44cce79211d8be05945::wise {
    struct WISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WISE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WISE>(arg0, 6, b"WISE", b"WISE AGENT", b"A wise old AI agent that comes with a lot of life experience and wisedom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/God_of_nature_ff4b40f7d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WISE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WISE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

