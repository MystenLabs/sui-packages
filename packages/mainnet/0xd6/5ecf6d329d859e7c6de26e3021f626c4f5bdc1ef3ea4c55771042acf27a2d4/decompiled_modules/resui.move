module 0xd65ecf6d329d859e7c6de26e3021f626c4f5bdc1ef3ea4c55771042acf27a2d4::resui {
    struct RESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESUI>(arg0, 6, b"RESUI", b"Resuistance Dog", b"Welcome to the Digital Resistance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Xt_Wwu_V1_M_400x400_11ce87495a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

