module 0x7ea46931c3534188ae2b9c2a885e98e632051bd33ebf187752c7288503a76df::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG>(arg0, 6, b"GG", b"GO GARY", b"FAREWELL POOR GARY AND RESPECT THE PUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730984784486.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

