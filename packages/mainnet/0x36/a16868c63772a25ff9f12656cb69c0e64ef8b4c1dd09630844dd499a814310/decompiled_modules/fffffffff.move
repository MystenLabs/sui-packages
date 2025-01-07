module 0x36a16868c63772a25ff9f12656cb69c0e64ef8b4c1dd09630844dd499a814310::fffffffff {
    struct FFFFFFFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFFFFFFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFFFFFFFF>(arg0, 6, b"FFFFFFFFF", b"DidSatoshiLivedInAGodDamnZoo", x"536f7272792062757420676f642064616d6e2069742e20492063616e74206b65657020757020776974682074686973206d616e7920616e696d616c732e20546869732061696e742061207a6f6f2e20486f77206d616e792066697273742063617473203f20486f77206d616e7920666972737420646f6773203f204765742075702021205374616e64207570202120536179206e6f20746f20627320210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ro_L_Wv_JUV_Bzo5_Kg_H9_RZKPT_3fw_C3o1nnx_C5_Kuk_B_Ub_AA_3yb_7300c99773.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFFFFFFFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFFFFFFFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

