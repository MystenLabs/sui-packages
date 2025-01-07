module 0x620ab51792c1dd4918b60ae92d4b80fce435d323e3115f5bd7b9d4ea986b276f::giko {
    struct GIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIKO>(arg0, 6, b"GIKO", b"First internet cat", b"First internet cat | $GIKO Giko Cat is the first cat on the internet, and the first cat meme to ever exist.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/H4iss_R_Cqw7_BW_Bhk235_Bj4_P8z_C_Wd_V1uty_Dx6_Ku_Gghm_GJC_0814b7e1d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

