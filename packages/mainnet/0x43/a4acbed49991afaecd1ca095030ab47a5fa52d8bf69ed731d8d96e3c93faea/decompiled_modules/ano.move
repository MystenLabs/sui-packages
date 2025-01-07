module 0x43a4acbed49991afaecd1ca095030ab47a5fa52d8bf69ed731d8d96e3c93faea::ano {
    struct ANO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANO>(arg0, 6, b"ANO", b"Anonime", x"596f752063616e27742067756573732077686f2068652069730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_M9u_Lr8ug5_P_Uqq_U9_Ntfzrn_V97xbiq_F3_U_Pjun_M6mt_HENB_40e429ab8b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANO>>(v1);
    }

    // decompiled from Move bytecode v6
}

