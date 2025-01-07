module 0x7a4040540deaf6d7057d4b8697c7fed29cdf25a03eabb05d8c5cbbf17f48f0f6::spyp {
    struct SPYP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPYP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPYP>(arg0, 6, b"SPYP", b"Sui PYP", x"49542753204c49474854494e47205448452057415920544f2056414c48414c4c41210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbmv_W_Dyi_HL_4_L_Bn_Fm8c_F_Eajn3dy_An_Sx_Wwod_Dhf_KG_Gz_Tn6_P_dbe20cca2d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPYP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPYP>>(v1);
    }

    // decompiled from Move bytecode v6
}

