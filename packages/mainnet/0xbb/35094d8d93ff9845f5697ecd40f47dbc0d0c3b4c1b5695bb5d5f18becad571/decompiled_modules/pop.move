module 0xbb35094d8d93ff9845f5697ecd40f47dbc0d0c3b4c1b5695bb5d5f18becad571::pop {
    struct POP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POP>(arg0, 6, b"POP", b"POPULA", b"official POPULA token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731325631825.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

