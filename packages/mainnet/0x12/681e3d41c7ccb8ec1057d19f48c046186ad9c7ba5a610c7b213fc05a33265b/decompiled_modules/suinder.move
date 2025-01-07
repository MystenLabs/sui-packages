module 0x12681e3d41c7ccb8ec1057d19f48c046186ad9c7ba5a610c7b213fc05a33265b::suinder {
    struct SUINDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINDER>(arg0, 6, b"SUINDER", b"SUINDERMAN", b"SUINDERMAN = SUI + SLENDERMAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956887417.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINDER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINDER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

