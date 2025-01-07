module 0xf6cb3fad9d0917248552b46b5e6025f21f7f4bb047aac88162e356a0f3e3968d::mustacheman {
    struct MUSTACHEMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSTACHEMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSTACHEMAN>(arg0, 6, b"MUSTACHEMAN", b"Face Hair", b"The MUSTACHE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C4583922_D91_D_425_C_8_BFD_5068521_BB_5_AE_a7a0d3d899.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSTACHEMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSTACHEMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

