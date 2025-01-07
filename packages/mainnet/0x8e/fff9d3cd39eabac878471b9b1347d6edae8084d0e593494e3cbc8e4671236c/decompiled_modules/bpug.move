module 0x8efff9d3cd39eabac878471b9b1347d6edae8084d0e593494e3cbc8e4671236c::bpug {
    struct BPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPUG>(arg0, 6, b"BPUG", b"BABY PUG", x"57656269737465203a2068747470733a2f2f746865626162797075672e636f6d0a0a58203a2068747470733a2f2f782e636f6d2f626162797075676f6e7375690a0a54473a2068747470733a2f2f742e6d652f626162797075676f6e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731191992797.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BPUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

