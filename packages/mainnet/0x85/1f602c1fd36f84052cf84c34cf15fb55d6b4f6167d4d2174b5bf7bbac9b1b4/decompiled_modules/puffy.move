module 0x851f602c1fd36f84052cf84c34cf15fb55d6b4f6167d4d2174b5bf7bbac9b1b4::puffy {
    struct PUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFY>(arg0, 6, b"PUFFY", b"puffionsui", b"The puffiest plop around sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/M2_T_Gsgpd_400x400_4bb13dc798.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

