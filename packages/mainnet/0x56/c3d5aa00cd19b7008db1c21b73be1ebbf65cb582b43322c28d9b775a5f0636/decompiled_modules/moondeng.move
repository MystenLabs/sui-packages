module 0x56c3d5aa00cd19b7008db1c21b73be1ebbf65cb582b43322c28d9b775a5f0636::moondeng {
    struct MOONDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONDENG>(arg0, 6, b"MOONDENG", b"MOON DENG", b"It's just a MOONDENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Yp_IDSDXUAA_O0h_f0fff1fc87.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

