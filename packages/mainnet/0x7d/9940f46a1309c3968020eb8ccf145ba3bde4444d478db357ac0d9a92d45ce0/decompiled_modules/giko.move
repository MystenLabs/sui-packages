module 0x7d9940f46a1309c3968020eb8ccf145ba3bde4444d478db357ac0d9a92d45ce0::giko {
    struct GIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIKO>(arg0, 6, b"GIKO", b"First internet cat", b"First internet cat | $GIKO Giko Cat is the first cat on the internet, and the first cat meme to ever exist.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/H4iss_R_Cqw7_BW_Bhk235_Bj4_P8z_C_Wd_V1uty_Dx6_Ku_Gghm_GJC_c82f99afea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

