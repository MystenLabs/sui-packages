module 0xbde0b4ef9032265ea9393e1af1baf92c93bdf36baaee8e042fed8a1ab3dafc6::abe {
    struct ABE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABE>(arg0, 6, b"ABE", b"Abe Bald Eagle", b"First Abe Bald Eagle on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_Zzt_Nf_N8y_Qbl_YJ_5lmb_V_Vd_BE_1_I_1_cd754eb52a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABE>>(v1);
    }

    // decompiled from Move bytecode v6
}

