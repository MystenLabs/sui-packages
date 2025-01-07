module 0x6381c84e14169bd72ae247d5cff5b228b9d3b24031888ada65fb3d4fc2608981::alienbrett {
    struct ALIENBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIENBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALIENBRETT>(arg0, 6, b"AlienBrett", b"Alien Brett", b"Alien Brett is crash landing on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Uu_HMQE_5h_N2_PDSZB_Yg7u_ZHXD_9cz_P_Lk_Lpi_AG_Va_S_Ak_L3_L7y_a5a95ae741.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIENBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALIENBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

