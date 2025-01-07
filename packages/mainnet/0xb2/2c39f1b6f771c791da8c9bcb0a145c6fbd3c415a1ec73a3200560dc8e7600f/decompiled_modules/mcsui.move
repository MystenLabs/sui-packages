module 0xb22c39f1b6f771c791da8c9bcb0a145c6fbd3c415a1ec73a3200560dc8e7600f::mcsui {
    struct MCSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCSUI>(arg0, 6, b"MCSUI", b"Mc Sui", b"I will help you retire.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Px_AEB_1_H8_400x400_96cc34acb1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

