module 0x11acc917ae07e96e02edd8a2933c7b760c6d2fc2c03c41b72610579c411efbbb::jesusui {
    struct JESUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUSUI>(arg0, 6, b"JESUSUI", b"JESUS on SUI", b"JESUS LOVES YOU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Yp_Gy_NNNR_400x400_1c9e968db7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

