module 0xb23269981aad87f8e711e2a4dfd01f14d3404a8ca12f7d8765147054e6bd178a::yuri {
    struct YURI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YURI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YURI>(arg0, 6, b"YURI", b"YURI ON SUI", x"4576657279626f64797320667269656e642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z_Syzq_Lo_LR_Ni_Ng_Ve7_Zar_LLRF_Hkej1mkjt5skioe_Z5e_E7_F_4080b2e804.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YURI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YURI>>(v1);
    }

    // decompiled from Move bytecode v6
}

