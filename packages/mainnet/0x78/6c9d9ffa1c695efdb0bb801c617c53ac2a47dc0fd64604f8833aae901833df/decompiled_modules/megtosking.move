module 0x786c9d9ffa1c695efdb0bb801c617c53ac2a47dc0fd64604f8833aae901833df::megtosking {
    struct MEGTOSKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGTOSKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGTOSKING>(arg0, 6, b"MegTosKing", b"MegVeg", b"MegTos is a vibrant and fun memecoin built on the Sui blockchain. Designed for the community and driven by humor, MegTos aims to bring together crypto enthusiasts and meme lovers alike. With a focus on creating an engaging ecosystem, MegTos leverages the power of memes to foster a lively community, encouraging creativity and collaboration. Join us as we embark on this exciting journey, spreading joy and value in the crypto space!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zhx_Rb1k_NM_9_KH_Rp_Amyo_WZ_6_NY_Vgq83jour_EQ_Ti_FC_44e_L_Xc_9085b8c693.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGTOSKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGTOSKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

