module 0xcd790191c1570469b151971fdf5756a4d632bf81efd15c1eaa64b74574a2d9d9::pole {
    struct POLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLE>(arg0, 6, b"POLE", b"POLESUI TOKEN", x"486920696d2024504f4c45202d204120626f726e20696e2074686520766173742c2066726f73747920776174657273206f662074686520537569207769746820612068756d6f722061732074686520504f4c450a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3594_a065f79f12.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

