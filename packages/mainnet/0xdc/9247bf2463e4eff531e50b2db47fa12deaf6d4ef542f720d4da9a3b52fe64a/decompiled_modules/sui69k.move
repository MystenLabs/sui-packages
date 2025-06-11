module 0xdc9247bf2463e4eff531e50b2db47fa12deaf6d4ef542f720d4da9a3b52fe64a::sui69k {
    struct SUI69K has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI69K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI69K>(arg0, 6, b"Sui69k", b"sui6900x10", b"ttt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yhw_Q_Lmqe_ENE_8_LY_Ejq3_M_Pp8_Z_Hgmos_C_Lvej_L8o9_Vmc_Vv_Z6_8f9407fc89.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI69K>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI69K>>(v1);
    }

    // decompiled from Move bytecode v6
}

