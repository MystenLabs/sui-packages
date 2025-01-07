module 0x3d500585c931ed7e95d29fe29d486f2f41f5e87822c16dd7128c4af363325a3b::tdoge {
    struct TDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDOGE>(arg0, 6, b"TDOGE", b"Turbos Doge", x"4c6574277320476fefbc81efbc81efbc81efbc81efbc81", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949632396.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

