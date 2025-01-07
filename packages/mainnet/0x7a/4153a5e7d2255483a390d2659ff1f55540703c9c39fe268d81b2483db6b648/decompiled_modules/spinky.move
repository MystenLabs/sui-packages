module 0x7a4153a5e7d2255483a390d2659ff1f55540703c9c39fe268d81b2483db6b648::spinky {
    struct SPINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPINKY>(arg0, 6, b"SPINKY", b"SUI PINKY", b"PINKY PINKY PINKY PINKY PINKY PINKY PINKY PINKY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_Jh_Mj_Az5rj_Y9_R4d_L_Zwrd_Rvh_Zkf_Tow_Pg62_Wi_Z7_Jz9pump_f064bbb78b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

