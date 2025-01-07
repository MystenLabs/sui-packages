module 0x7d9005f1791999f312c9ec1ec22e4d9986dd88abb4c3bc5457a1c22e58bc3ca0::burnai {
    struct BURNAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURNAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURNAI>(arg0, 6, b"BURNAi", b"BORN TO BURN", b"Why us.Alpha play.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/freecompress_Qm_Yghr_Z8i3_Ysz_Vno_Rj_BQEFNDPDLP_84_D1acz323g8t_Lz1i_J_1_imageonline_co_4803922_0620ab8e90.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURNAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURNAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

