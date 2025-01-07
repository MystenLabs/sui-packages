module 0xe1de687dfc3b956cb66ed5b5381cf959ca6d90b1b4fa44b505978bec0bd9782a::hankey {
    struct HANKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANKEY>(arg0, 6, b"HANKEY", b"Mr Hankey on Sui", b"I'm Mr. Hankey, the Ultimate Shitcoin! Together, let's send this shit! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2n_Nm_L_Qyig_Dz_Qw_F8_Pb51o8_T8m_Yv_CPXEEH_Qjt_WZ_Tf_Epump_7448715e15.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

