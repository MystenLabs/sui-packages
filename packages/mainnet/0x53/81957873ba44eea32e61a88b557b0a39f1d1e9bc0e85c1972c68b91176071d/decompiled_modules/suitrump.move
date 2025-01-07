module 0x5381957873ba44eea32e61a88b557b0a39f1d1e9bc0e85c1972c68b91176071d::suitrump {
    struct SUITRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITRUMP>(arg0, 6, b"SUITRUMP", b"Sui Trump", b"The OG Trump coin on the Sui network, $SUITRUMP is here to make Sui great again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dj_Gf6_EKY_Tb_S_Lq_W8_Hf5x_Ttw_bb6a71ac9f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

