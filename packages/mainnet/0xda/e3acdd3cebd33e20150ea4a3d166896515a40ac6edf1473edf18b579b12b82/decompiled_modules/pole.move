module 0xdae3acdd3cebd33e20150ea4a3d166896515a40ac6edf1473edf18b579b12b82::pole {
    struct POLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLE>(arg0, 6, b"POLE", b"BLUE POLE SUI", x"486920696d2024504f4c45202d204120626f726e20696e2074686520766173742c2066726f73747920776174657273206f662074686520537569207769746820612068756d6f722061732074686520706570650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3594_cdeb9a1cbd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

