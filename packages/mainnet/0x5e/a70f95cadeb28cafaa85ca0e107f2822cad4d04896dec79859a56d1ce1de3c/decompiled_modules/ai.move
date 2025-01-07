module 0x5ea70f95cadeb28cafaa85ca0e107f2822cad4d04896dec79859a56d1ce1de3c::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI>(arg0, 6, b"AI", b"Serial Experiments Lain : AI", x"636f6e6e6563746564207468726f7567687420746865206e6574776f726b2077652061726520616c6c20696e206861726d6f6e79207769746820676f642e2077616b652075700a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_ZGRN_Azxifhgd_Ttg_Zv_G5_Z84_Pp_Rq_Ki_Qx3_M_Qi_R_Korui_Jx_BK_025f04a9ac.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI>>(v1);
    }

    // decompiled from Move bytecode v6
}

