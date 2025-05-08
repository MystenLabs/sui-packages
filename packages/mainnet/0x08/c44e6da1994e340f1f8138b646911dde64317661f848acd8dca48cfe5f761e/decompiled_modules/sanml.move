module 0x8c44e6da1994e340f1f8138b646911dde64317661f848acd8dca48cfe5f761e::sanml {
    struct SANML has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANML>(arg0, 6, b"SANML", b"SuiAnimals", b"meoww", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zf_Ani_A_No_400x400_67a27cfe90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANML>>(v1);
    }

    // decompiled from Move bytecode v6
}

