module 0x15dc3cd8d574c80e6edc98c2def85637a707d84665042ab94331f9081ddb4471::doby {
    struct DOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOBY>(arg0, 6, b"DOBY", b"Doby", b"DOBY is the next-gen memecoin, drawing inspiration from the fierce loyalty and unstoppable energy of the iconic Doberman dog. Just like its namesake, DOBY is here to make a strong, reliable mark in the crypto space. Designed for a community of crypto enthusiasts who value strength, loyalty, and fun, DOBY combines the playful charm of meme culture with real utility. With big plans for the future, including NFTs and community-driven initiatives, DOBY aims to go beyond the typical meme coin and offer something exciting for both casual investors and seasoned traders alike.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmeekq_Xvsv_Kusvrrg_Rf_D_Xt6kr_Lnk_Lic_FBJ_Kb_Fah_F_Xd_XHUS_971273693c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

