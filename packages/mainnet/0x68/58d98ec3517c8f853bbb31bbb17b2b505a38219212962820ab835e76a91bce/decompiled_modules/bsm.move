module 0x6858d98ec3517c8f853bbb31bbb17b2b505a38219212962820ab835e76a91bce::bsm {
    struct BSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSM>(arg0, 6, b"BSM", b"Back Shot Mathematics", b"Calculate your pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vs_XQ_Vndo4kn_G3_Vv7i84_F_Zv_Njw5vc3_G7addczh_JWD_Cpd_B_e842b5a70a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

