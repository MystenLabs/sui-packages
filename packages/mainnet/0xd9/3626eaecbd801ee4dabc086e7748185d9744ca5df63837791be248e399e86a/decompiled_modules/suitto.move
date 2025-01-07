module 0xd93626eaecbd801ee4dabc086e7748185d9744ca5df63837791be248e399e86a::suitto {
    struct SUITTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITTO>(arg0, 6, b"SUITTO", b"SUITO", b"Suitto will transform Sui. Morph into the trend and beat jeeters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_QX_Bmck_Z_400x400_c36860156b_d94ab1a9fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

