module 0x3ebe8e5d2239a3ec2b925779917d85186c2d7dad5f674665fcd53d9042d9f1c2::pipo {
    struct PIPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPO>(arg0, 6, b"PIPO", b"pipo on sui", b"Hi, I'm pipo on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rodh_H2_Xivnpt9_Aj_K1_Zni_Rap6_T_Tc_K1yx9_C_Jm_Z5zq_Pipo_9170de3ed2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

