module 0x9545d2a01d8e48a230201c8a3d3e0009d741c614a2cae3905aca65ddbfa2e428::jess {
    struct JESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESS>(arg0, 6, b"Jess", b"Jesse", b"I'm just Pepe's sister", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_Ngy_QS_Gue5_N_Fcu24_Qdkwhuq_Mo_Zosy_X3_Z_Mz_R_Czmk1_WPCZ_83b609e547.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

