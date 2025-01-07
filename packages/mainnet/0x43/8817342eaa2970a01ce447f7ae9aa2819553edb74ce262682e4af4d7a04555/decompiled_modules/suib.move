module 0x438817342eaa2970a01ce447f7ae9aa2819553edb74ce262682e4af4d7a04555::suib {
    struct SUIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIB>(arg0, 6, b"SUIB", b"SUI BULL", b"UI Bull charging upward, decked out in a golden helmet, flexing muscles and ready to conquer the bull market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_bull_77e9a78f26.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

