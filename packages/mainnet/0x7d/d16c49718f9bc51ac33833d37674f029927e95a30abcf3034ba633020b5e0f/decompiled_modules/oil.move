module 0x7dd16c49718f9bc51ac33833d37674f029927e95a30abcf3034ba633020b5e0f::oil {
    struct OIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OIL>(arg0, 6, b"OIL", b"OIL MONEY", b"THE OILERS ARE MAKING THEIR WAY TO SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_Zmnx_NX_700b_91d3a5c9ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

