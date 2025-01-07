module 0x1e7efd0b497a7a75edb99a7b0c495211aeeafa800449620644737af339ddf4a9::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG>(arg0, 6, b"DOG", b"First Dog of 2025", b"First Dog of 2025 ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf7f2nn_D9p_P3_QQ_Rc1krmi_Ki_D3_Str_DX_Xz_Cx_A1_Ky_Me_F_Jn_UX_43b6a73020.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

