module 0x27a695ba191a47293c1d0a2a671d355517aa50ce48edfacf66ad85a9a509a6f::lads {
    struct LADS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LADS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LADS>(arg0, 6, b"LADS", b"Mysten Lads", b"I want it that way (with objects) will be the main single", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736132738291.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LADS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LADS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

