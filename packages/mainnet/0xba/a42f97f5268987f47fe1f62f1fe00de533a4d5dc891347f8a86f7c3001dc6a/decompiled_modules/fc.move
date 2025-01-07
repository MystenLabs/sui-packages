module 0xbaa42f97f5268987f47fe1f62f1fe00de533a4d5dc891347f8a86f7c3001dc6a::fc {
    struct FC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FC>(arg0, 6, b"FC", b"Fat Cat", b"Fat Cat in the Fall", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ya_Xe_E8z_Gz_D_Pa_A6_Fu_HQBU_17_Ek3g_VHBF_Tsein_KQ_2m_Nw_PYS_d599b55b90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FC>>(v1);
    }

    // decompiled from Move bytecode v6
}

