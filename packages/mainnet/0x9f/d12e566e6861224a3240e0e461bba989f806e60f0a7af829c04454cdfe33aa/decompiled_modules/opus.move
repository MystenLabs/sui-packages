module 0x9fd12e566e6861224a3240e0e461bba989f806e60f0a7af829c04454cdfe33aa::opus {
    struct OPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPUS>(arg0, 6, b"Opus", b"Claude Opus", b"First AI model created by @AndyAyrey Adam = Opus EVE = truth_terminal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbe_Qt_DE_Dvdb_YY_Pcmf_Mz_D_Soyb_XVXE_4s7td_Wuy48_Lf_A1j_QP_bb6c9deb88.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

