module 0x8b5bac9eb04d28ac15a642741af1619cf58638e1da94f6ade525cbd53f1f989c::crazy {
    struct CRAZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAZY>(arg0, 6, b"CRAZY", b"Crazy Frog", x"46726f6720676f65732064696e672064696e672062616d2062616d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_TK_Daoh4_Kh53_Tn168b_Ewtsa_Hx_SF_Redi_Yc_QC_Gsn52da_Zc_U_d3693e937d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

