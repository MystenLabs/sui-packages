module 0x1c18fc73f35d1063374347c85e92e66d0875e9e4a4d826955f18228fe5ce2c01::cato {
    struct CATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATO>(arg0, 6, b"CATO", b"Catosui", b"CATO CATO CATO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SQDGF_Lr3ofm2oxoe_S_Cico_V7c_WEE_Xg_MH_Vbmv_E1_Y79fgu_Z_b265a1075e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

