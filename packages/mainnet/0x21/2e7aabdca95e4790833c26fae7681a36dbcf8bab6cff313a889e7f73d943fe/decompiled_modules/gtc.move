module 0x212e7aabdca95e4790833c26fae7681a36dbcf8bab6cff313a889e7f73d943fe::gtc {
    struct GTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTC>(arg0, 6, b"GTC", b"Gizmo The Cat", b"@lepuppeteerfou s cat Gizmo!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_K4u_KPP_11_Jfs_Zg_NS_4m4b_Su_Td3kx5m_R_Jxmf3_GUQ_8c9j_Yt_ac9a184fb2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

