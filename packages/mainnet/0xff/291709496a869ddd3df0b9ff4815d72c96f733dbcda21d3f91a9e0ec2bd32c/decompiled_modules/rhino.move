module 0xff291709496a869ddd3df0b9ff4815d72c96f733dbcda21d3f91a9e0ec2bd32c::rhino {
    struct RHINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHINO>(arg0, 6, b"RHINO", b"RHINO COIN", b"RHINO TOKEN ON SUI IS HERE. LFG! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_cartoon_style_illustration_of_a_rhinoceros_with_k_TF_Pa_Iy_G_Tvan_AX_8fyq_HK_7w_K_Lb_Q7_VT_Soi_U67zs_Dkr_E_Pg_0b28f39629.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RHINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

