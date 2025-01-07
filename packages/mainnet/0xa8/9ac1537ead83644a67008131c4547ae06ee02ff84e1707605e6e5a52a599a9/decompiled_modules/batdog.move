module 0xa89ac1537ead83644a67008131c4547ae06ee02ff84e1707605e6e5a52a599a9::batdog {
    struct BATDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATDOG>(arg0, 6, b"BATDOG", b"Batdog", b"Batdog is ready.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W5_MG_99149c98s9_Jp_Yz_W8_Y7f_X2_Uzyof9u_Np_FPA_Lobf2_Hk_c74eb61354.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

