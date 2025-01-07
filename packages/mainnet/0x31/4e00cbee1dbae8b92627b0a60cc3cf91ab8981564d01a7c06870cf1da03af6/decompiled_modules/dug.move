module 0x314e00cbee1dbae8b92627b0a60cc3cf91ab8981564d01a7c06870cf1da03af6::dug {
    struct DUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUG>(arg0, 6, b"DUG", b"Dug On Sui", b"dug dug dug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z_Kn_Y_Kx1e_Tz_FW_9p1m5j_P_Jyx_FRZN_Xcvnvg_Nidkf_Kx_BT_Shw_7df5f16820.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

