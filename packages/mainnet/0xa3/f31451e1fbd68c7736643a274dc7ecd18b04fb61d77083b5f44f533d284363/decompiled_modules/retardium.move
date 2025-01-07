module 0xa3f31451e1fbd68c7736643a274dc7ecd18b04fb61d77083b5f44f533d284363::retardium {
    struct RETARDIUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARDIUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARDIUM>(arg0, 6, b"RETARDIUM", b"Retardium", b"The last element on the periodic table - RETARDIUM Scientists searched long and hard to find the elusive Retardium. In true retarded fashion they even dug through the XRP blockchain and other chains from the stone age, and they finally found Retardium by an accident.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xaa_Qex_YB_Snbg4_Wj_Qco78_G5_Nj13_Vu8_Sg52_Sa_Gr_Y_Bx_PZJ_6_693410016f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARDIUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETARDIUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

