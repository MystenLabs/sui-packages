module 0xe9c859f2df72e05948b59ecfed3930561969672baf75d39f1ad20108c3ace0e0::stupid {
    struct STUPID has drop {
        dummy_field: bool,
    }

    fun init(arg0: STUPID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STUPID>(arg0, 6, b"STUPID", b"STUPID GUY", x"547970696320476f74626974277320656d706c6f796565730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_VX_Xpeat4_V_Jb_WCZ_3diw_Mphmkw_Na_Nb8b_Hxax_Sd_YESC_Eq4_S_1ca54e0d0f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STUPID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STUPID>>(v1);
    }

    // decompiled from Move bytecode v6
}

