module 0x6c555ccc6e48b444225dec4504e8d6ec04682e2fbbf6bd5bdf69f29bf3e04d14::scit {
    struct SCIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCIT>(arg0, 6, b"SCIT", b"SUI CIT", x"43697420746865206361740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Re9m_Tz_Yawz74_Bgna2s_KY_Ab_Qgs726_Ezc6_Qj_Mqnv_W_Jy3_Bq_6c26fc3f33.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

