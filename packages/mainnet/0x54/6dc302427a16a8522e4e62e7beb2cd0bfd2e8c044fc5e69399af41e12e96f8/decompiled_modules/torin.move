module 0x546dc302427a16a8522e4e62e7beb2cd0bfd2e8c044fc5e69399af41e12e96f8::torin {
    struct TORIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORIN>(arg0, 6, b"Torin", b"Official Mascot of Tesla", x"546865206f6666696369616c206d6173636f74206f6620546f72696e20546865204f4e4c5920746f6b656e20656e646f727365642062792054726f7920576f6c6672616d202d2043686965662044657369676e200a405465736c610a200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gb_He_VX_Xb_QA_Ak_WOI_d29163e0d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

