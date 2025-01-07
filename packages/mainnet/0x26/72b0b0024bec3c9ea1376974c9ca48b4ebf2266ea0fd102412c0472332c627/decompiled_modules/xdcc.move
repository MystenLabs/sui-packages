module 0x2672b0b0024bec3c9ea1376974c9ca48b4ebf2266ea0fd102412c0472332c627::xdcc {
    struct XDCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: XDCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XDCC>(arg0, 6, b"XDCC", b"X12", b"CHILL PNUT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chillguy_1_g_ID_7_8ae16aa5cb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XDCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XDCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

