module 0x365ea35991c186a1e0edbb97aab0e0d5ce3246410488c64529a3c7fd7a212fb0::labubu {
    struct LABUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBU>(arg0, 6, b"LABUBU", b"LABUBU on SUI", b"Spread the cuteness of labubu to the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/JB_2wez_Z_Ldz_Wfna_Cf_Hx_Lg193_RS_3_Rh51_Thi_Xx_EDWQ_Dpump_aa68d571d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LABUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

