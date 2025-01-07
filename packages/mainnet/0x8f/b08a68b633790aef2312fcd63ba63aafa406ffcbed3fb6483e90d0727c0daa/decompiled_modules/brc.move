module 0x8fb08a68b633790aef2312fcd63ba63aafa406ffcbed3fb6483e90d0727c0daa::brc {
    struct BRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRC>(arg0, 6, b"BRC", b"Bruce", b"Bruce meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SLG_12p_H4gd9g_CB_1_Cqu_A8_X_Nb_FER_3_Bu_Q4_KKR_62_B6jdz8_W6_43d7a52e59.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

