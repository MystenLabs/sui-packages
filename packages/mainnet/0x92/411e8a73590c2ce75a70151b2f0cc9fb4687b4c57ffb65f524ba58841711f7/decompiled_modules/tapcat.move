module 0x92411e8a73590c2ce75a70151b2f0cc9fb4687b4c57ffb65f524ba58841711f7::tapcat {
    struct TAPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAPCAT>(arg0, 6, b"TapCat", b"TAPCAT", x"54686520636174206b656570732074617070696e670a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vm_W6_PXFU_8d4hp_T9b_Prx_N2_G89_Wqhw3mkujpe_HJYR_7qm3i_d7d3ce2d26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

