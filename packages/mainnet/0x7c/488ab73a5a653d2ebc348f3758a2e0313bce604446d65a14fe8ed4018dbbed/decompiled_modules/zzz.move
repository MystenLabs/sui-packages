module 0x7c488ab73a5a653d2ebc348f3758a2e0313bce604446d65a14fe8ed4018dbbed::zzz {
    struct ZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ZZZ>(arg0, 6, b"ZZZ", b"zzz by SuiAI", b"zzz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/test_button_1_01940a868b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZZZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

