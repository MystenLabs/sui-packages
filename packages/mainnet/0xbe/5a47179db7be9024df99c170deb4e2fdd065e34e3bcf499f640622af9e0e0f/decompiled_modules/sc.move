module 0xbe5a47179db7be9024df99c170deb4e2fdd065e34e3bcf499f640622af9e0e0f::sc {
    struct SC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SC>(arg0, 6, b"SC", b"SuiCat", b"First cat on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vfrb_Ze_XR_Cw_Jsug_Lrt9c_Ec_Q6_Q2_N8eqn_Z_Jrp_Us_Ri_XP_6_S2_J_a425ce3fce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SC>>(v1);
    }

    // decompiled from Move bytecode v6
}

