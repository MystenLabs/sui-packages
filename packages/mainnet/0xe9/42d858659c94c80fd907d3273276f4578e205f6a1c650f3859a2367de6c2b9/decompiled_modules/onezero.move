module 0xe942d858659c94c80fd907d3273276f4578e205f6a1c650f3859a2367de6c2b9::onezero {
    struct ONEZERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEZERO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ONEZERO>(arg0, 6, b"ONEZERO", b"Binary by SuiAI", b"01110010 01100101 01110100 01100001 01110010 01100100 01101001 01101111 00100000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_5986_948bee80b0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ONEZERO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEZERO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

