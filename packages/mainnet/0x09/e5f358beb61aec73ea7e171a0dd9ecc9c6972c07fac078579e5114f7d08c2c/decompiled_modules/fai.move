module 0x9e5f358beb61aec73ea7e171a0dd9ecc9c6972c07fac078579e5114f7d08c2c::fai {
    struct FAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAI>(arg0, 6, b"FAI", b"FREELANCE AI", b"AI-powered SUI decentralized freelancing platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmai_C5hmm_Ss_Fwu_Q_Wq_P_Jb_Tkx_D9_C5_WCWH_6cs5_X8c_UX_43ws_J9_b0e6e01e93.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

