module 0x73e6eea6d6d550b57423a93226dd08666133d2718660eef0f7e9a65627a3be38::pesto {
    struct PESTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESTO>(arg0, 6, b"PESTO", b"Pesto the Baby King Penguin", b"Pestotokensui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/90_F93v_WU_400x400_7f98b32f76.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PESTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

