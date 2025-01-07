module 0xd1e4db350e463a8abcf2fc362fb1c5b5b82bcc9ba9bf1f546691822ae4b70fee::tdog {
    struct TDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDOG>(arg0, 6, b"TDOG", b"terminal dog", b"/dogbillions --wealth infinity --chill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wn_Pks_Kdn_L_Hgkk_Dwd_C2_HL_Hs_Ch_Qjmeq13kk_Der_Mv_A_Baa_D1_c5d63c644c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

