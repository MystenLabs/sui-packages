module 0xe351fd4224963f7d5776fd220c874d46e432ed244a63831d08d448a7999da7ea::hope {
    struct HOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPE>(arg0, 6, b"HOPE", b"HOPEONSUI", b"HOPE is here to give you hope inside all the chaos of crypto, embrace urself and be high with us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QFT_8k_Zu3fb_Ta_Zzy_LCLU_Efd4h43_Ja_Sqxap_D_Ri_Lefa_K2_N1_659a30e3a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

