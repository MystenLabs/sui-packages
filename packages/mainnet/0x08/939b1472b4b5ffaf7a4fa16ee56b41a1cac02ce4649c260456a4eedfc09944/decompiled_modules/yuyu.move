module 0x8939b1472b4b5ffaf7a4fa16ee56b41a1cac02ce4649c260456a4eedfc09944::yuyu {
    struct YUYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUYU>(arg0, 6, b"YUYU", b"YUYUSUI", b"Meet YUYU - famous asian internet dog who likes to dress!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W_Cy_Sb_Aaa_Af6m_LK_Wg_WUGG_4o6_Rz6jp_P1d3_SU_Lc2_Ts_Cj3kd_b71b3a4582.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

