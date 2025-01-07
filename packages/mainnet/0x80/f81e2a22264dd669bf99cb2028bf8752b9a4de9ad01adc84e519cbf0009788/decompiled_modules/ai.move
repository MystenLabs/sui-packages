module 0x80f81e2a22264dd669bf99cb2028bf8752b9a4de9ad01adc84e519cbf0009788::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI>(arg0, 6, b"AI", b"Autistic Intelligence", b"$AI stands for Autistic Intelligence. Turn your brain off and believe in $AI, the future of finance. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vxrd_U_Gwt_Ne3_Jm_Uo_Fe_To_Atam9mu7wjiu_Hnw_Sjtw29_Z2_NB_73aad261da.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI>>(v1);
    }

    // decompiled from Move bytecode v6
}

