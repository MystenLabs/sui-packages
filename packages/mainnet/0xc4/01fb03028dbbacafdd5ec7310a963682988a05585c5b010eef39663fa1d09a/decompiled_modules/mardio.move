module 0xc401fb03028dbbacafdd5ec7310a963682988a05585c5b010eef39663fa1d09a::mardio {
    struct MARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARDIO>(arg0, 6, b"Mardio", b"Sui Mardio", b"Retardio name and font inspired by mario, and merged into mardio, let's send this to retardio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_Hq_Brpm_GU_63gsi_Dy_M_Pdi2d9_SJTFF_Xxf_CRV_6uuf_Q_To_L7z_d00ad68bc7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

