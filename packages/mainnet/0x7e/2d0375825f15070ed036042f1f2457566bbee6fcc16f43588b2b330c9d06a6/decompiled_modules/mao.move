module 0x7e2d0375825f15070ed036042f1f2457566bbee6fcc16f43588b2b330c9d06a6::mao {
    struct MAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAO>(arg0, 6, b"MAO", b"MAO MAO", b"MAO ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbynok_Qz2_Tc_Rj_Uia_L3i6zb2_Z6_Tzar_Vsfg_M_Ra_KZE_4e7syz_557299efc5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

