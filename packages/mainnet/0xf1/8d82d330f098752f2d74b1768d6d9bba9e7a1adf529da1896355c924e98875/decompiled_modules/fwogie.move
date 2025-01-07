module 0xf18d82d330f098752f2d74b1768d6d9bba9e7a1adf529da1896355c924e98875::fwogie {
    struct FWOGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOGIE>(arg0, 6, b"FWOGIE", b"SUI FWOGIE", x"4869206d79206e616d652069732046574f474945202d2046574f4727532057494645205468697320746f6b656e206973206372656174656420666f7220636f6d6d756e69747920746f2072756e20627920636f6d6d756e6974790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_Upnru_Ecp_Ygwbzy_Fhje_KC_5_KA_3aw4k_RQ_Ds_P_Ccqqv1yx_KD_7e6946e816.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

