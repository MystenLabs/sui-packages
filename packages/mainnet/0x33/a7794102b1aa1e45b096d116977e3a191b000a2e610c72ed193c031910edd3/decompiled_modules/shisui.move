module 0x33a7794102b1aa1e45b096d116977e3a191b000a2e610c72ed193c031910edd3::shisui {
    struct SHISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHISUI>(arg0, 6, b"SHISUI", b"SHISUI UCHIHA", b"Based after the all seeing Shisui Uchiha from Naruto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shisui_947690af08.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

