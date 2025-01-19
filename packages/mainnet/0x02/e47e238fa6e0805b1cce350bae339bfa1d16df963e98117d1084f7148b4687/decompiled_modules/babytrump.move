module 0x2e47e238fa6e0805b1cce350bae339bfa1d16df963e98117d1084f7148b4687::babytrump {
    struct BABYTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYTRUMP>(arg0, 6, b"BABYTRUMP", b"OG OFFICIAL BABY TRUMP", b"We are a brand new community inspired by President Trumps crypto-first and America-first vision. With the President's appointment of leaders in crypto and AI, BABYTRUMP is here to revolutionize the crypto space, rallying support to Make America Great Again with blockchain innovation at its core.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_ZB_Jw_Dixm55_R7_Gu8_Fy787dr1v_Rg_WHH_2_Gt9_Zwkjdx_Akm_YU_295be60a54.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

