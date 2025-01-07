module 0x5a6fe679cb28e6ade2ae3c29dafd787aabc630b4bee8b221846c5148d44c1edc::dogbromoon {
    struct DOGBROMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGBROMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGBROMOON>(arg0, 6, b"DOGBROMOON", b"DogBro Moon", b"For when your portfolio needs more bark than bite! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_V2s5f77_V_Mer_A_Za7jwta1_Fi8_NX_2_Em_D_Qa_Tha_Jsntrh_Vk9_Q_a1a77a88a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGBROMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGBROMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

