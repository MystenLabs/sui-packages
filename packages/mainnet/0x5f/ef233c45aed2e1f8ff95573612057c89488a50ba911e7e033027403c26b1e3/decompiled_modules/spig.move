module 0x5fef233c45aed2e1f8ff95573612057c89488a50ba911e7e033027403c26b1e3::spig {
    struct SPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIG>(arg0, 6, b"SPIG", b"SUIPIG", b"Just a pig.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_t_B_Ap_RO_Me0_BFLS_Xors_Hr4tw_2x_f6aad11c5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

