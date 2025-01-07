module 0xaf9b2d6d10b41042541287f22d0d3da8940b1617069336a77d16bf4a39da1928::pu {
    struct PU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PU>(arg0, 6, b"PU", b"PunPun by SuiAI", b"Dedicated to the great wizard PunPun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_289af4c12c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

