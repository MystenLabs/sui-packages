module 0x26ac262c4c955e5eb386286fb88728476292f94ea2e3533e7ed013183359f5f::kaspy {
    struct KASPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KASPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KASPY>(arg0, 6, b"KASPY", b"Kaspy", b"The Three Legged MEME cat! $KASPY on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ym_H_Em_BHAPA_Yxq_Jedfem_Kc_K8a3q_Dk9_Rp9t_R_Wk_Y4_Km9d_Me_c7cca550ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KASPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KASPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

