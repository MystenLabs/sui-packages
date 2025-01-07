module 0x9e0bdb813c45990dd977028b8cbe1e5dcbd8c2b5147882f16e682f29456c4c2d::suni {
    struct SUNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNI>(arg0, 6, b"SUNI", b"SUISUNI", b"Enter the world of SUNI, the magical unicorn igniting SUI's Bullrun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/file_z3_Ru_IF_3lt_Pv_MF_Ob85ft_F7u_ZS_b593c4128c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

