module 0x56ba569c1927e875dd769b3a40832da0ea346b2765cc20190b75e0a4f526a416::abstract {
    struct ABSTRACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABSTRACT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABSTRACT>(arg0, 6, b"ABSTRACT", b"Abstract Dog", b"The first abstract meme on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rqa_Spki_EE_Kt7n_MYV_4b_LA_Urfssz_N2dmh_KG_83_Ncx_Xzhra_N_9eda65e6b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABSTRACT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABSTRACT>>(v1);
    }

    // decompiled from Move bytecode v6
}

