module 0x2f23d7334c7877657ec78c543ef937e1f908b9570aa2ec2815d9db9aad19b79::dude {
    struct DUDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUDE>(arg0, 6, b"DUDE", b"DUDE SUI", b"Meet $DUDE, the chillest bro on the block who just wants to kick back, vibe, and watch the crypto world unfold. $DUDE isnt here to hustle or stressits here to remind you that, well, sometimes its just about being a DUDE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ci_Unt_Y1_Gae_Aib_Vofd_Hp5_Pu_Kcom_WZ_Zrn_H2khz_KH_Ueu_C8_R_b2cff028cb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

