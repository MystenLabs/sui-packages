module 0x7f3101c179f37d1cb49d9b7059938509264ceeaa39e05646b786e4eb674954d8::bubbles {
    struct BUBBLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLES>(arg0, 6, b"Bubbles", b"Sea Otter", b"The sea otter meta shifter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcfe5_M7_Vg_AU_Rb_T_Sw_K4ec_QKU_Kupkr_G_Prwij1_CYS_Va_E_Te_LS_456d103c1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

