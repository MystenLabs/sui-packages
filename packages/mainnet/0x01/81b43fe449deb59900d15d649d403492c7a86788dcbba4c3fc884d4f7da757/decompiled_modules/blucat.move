module 0x181b43fe449deb59900d15d649d403492c7a86788dcbba4c3fc884d4f7da757::blucat {
    struct BLUCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUCAT>(arg0, 6, b"BLUCAT", b"blucat", b"more than just a cats!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zk7djqtvwo_Gy_TLU_Mqtc1a_Hn47_G3_D_Dh5nitv2_JEKV_Ph_Tv_cfd86b8187.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

