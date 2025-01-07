module 0x3d0a0792bf72fb7fd8e570c61497c6ae88010634a8d18d349e225eea0a774fdf::bolt {
    struct BOLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLT>(arg0, 6, b"Bolt", b"$0.4 million Pigeon", x"41726d616e646f2074686520726163696e6720706967656f6e2073656c6c7320666f72207265636f72642024312e34206d696c6c696f6e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_NWR_26n3g_HD_4cpw_Kw_Tz_Qn_Biftdh_Jcyv_GMV_Yd_N6w_Ki_Nf9_9cef008983.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

