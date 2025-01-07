module 0xf1a2acd2186d2fa184170199454216d03ec2d0ba037f45069b63f8669528e34f::jellyai {
    struct JELLYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLYAI>(arg0, 6, b"JellyAI", b"Jelly AI", x"4a656c6c79416c2773206d697373696f6e20697320746f2070726f7669646520796f752077697468206120626574746572206675747572652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_YZ_5zt_Aa_Abho_ZL_8_Gn_E_Jn_Hgaa_Xey_Sj_Ui_D739um1_Mf_AV_2_FA_2348fd5ea7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLYAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JELLYAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

