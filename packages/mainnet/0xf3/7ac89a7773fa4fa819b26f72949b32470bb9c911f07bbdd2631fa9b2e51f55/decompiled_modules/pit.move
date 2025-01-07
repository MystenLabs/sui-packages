module 0xf37ac89a7773fa4fa819b26f72949b32470bb9c911f07bbdd2631fa9b2e51f55::pit {
    struct PIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIT>(arg0, 6, b"PIT", b"pit", b"PIT is a lovable cartoon cat and the loyal companion of Pepe the Frog,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z_Lrvuk_JE_Wsf_VEGQPED_5gwdppc_Z_Gq_Dakog_Z7m_Ya_GW_8_Kk_R_20ed0b3e64.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

