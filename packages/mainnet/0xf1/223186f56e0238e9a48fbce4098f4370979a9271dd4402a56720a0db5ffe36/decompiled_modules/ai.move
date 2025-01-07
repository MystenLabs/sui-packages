module 0xf1223186f56e0238e9a48fbce4098f4370979a9271dd4402a56720a0db5ffe36::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI>(arg0, 6, b"AI", b"Autistic Intelligence", x"244149207374616e647320666f7220417574697374696320496e74656c6c6967656e63652e205475726e20796f757220627261696e206f666620616e642062656c6965766520696e202441492c2074686520667574757265206f662066696e616e63652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vxrd_U_Gwt_Ne3_Jm_Uo_Fe_To_Atam9mu7wjiu_Hnw_Sjtw29_Z2_NB_73aad261da_59e5ec4c0f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI>>(v1);
    }

    // decompiled from Move bytecode v6
}

