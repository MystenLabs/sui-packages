module 0x551e583f305461669d9efca69e0b2fb0b7deb138b8f6a607e3c028f2e057cfba::hrky {
    struct HRKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRKY>(arg0, 6, b"HRKY", b"SHARKY", b"SUI memecoin's predator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/file_Sv_Tqud_E_Er_A_Ci_Y_Xtmkp_QT_37_5c7aed6274.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HRKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

