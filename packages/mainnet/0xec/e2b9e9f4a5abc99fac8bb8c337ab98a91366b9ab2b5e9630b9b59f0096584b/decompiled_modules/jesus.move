module 0xece2b9e9f4a5abc99fac8bb8c337ab98a91366b9ab2b5e9630b9b59f0096584b::jesus {
    struct JESUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUS>(arg0, 6, b"JESUS", b"Jeseus Maximus", b"god blass you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ykzqt7_B75_Jqv_Nuo_Ep52np_Y_So_Zxzbyu_YC_Rg_Gkp3o5v_XVK_2273a122d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

