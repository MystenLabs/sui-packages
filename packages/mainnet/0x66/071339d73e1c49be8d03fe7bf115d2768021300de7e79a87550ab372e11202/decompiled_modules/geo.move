module 0x66071339d73e1c49be8d03fe7bf115d2768021300de7e79a87550ab372e11202::geo {
    struct GEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GEO>(arg0, 6, b"GEO", b"Geovaneninho", b"G3O", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/GT_2_UBUX_0_AAQ_3r_Uboyfriend_1d04f65d9f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GEO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

