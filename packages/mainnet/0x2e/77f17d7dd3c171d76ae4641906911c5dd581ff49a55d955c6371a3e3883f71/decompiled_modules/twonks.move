module 0x2e77f17d7dd3c171d76ae4641906911c5dd581ff49a55d955c6371a3e3883f71::twonks {
    struct TWONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWONKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWONKS>(arg0, 6, b"TWONKS", b"Twonks on Sui", b"Twonks is a community-driven Sui meme token inspired by the hilariously absurd world of Twonks Comics by Steve Nelson. With its roots in satire and mischief, Twonks aims to become the most outrageously entertaining memecoin in existence, celebrating the comic universes humor and the power of memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/66_F1_Ffby_N_Sen_Hy_USZ_5yofw_H4r7_D_Ba_Fe5_Q_Qv_W_Zq_Ldpump_191d51d66e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWONKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWONKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

