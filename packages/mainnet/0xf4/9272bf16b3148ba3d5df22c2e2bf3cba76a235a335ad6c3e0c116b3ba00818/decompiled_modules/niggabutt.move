module 0xf49272bf16b3148ba3d5df22c2e2bf3cba76a235a335ad6c3e0c116b3ba00818::niggabutt {
    struct NIGGABUTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGABUTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGABUTT>(arg0, 6, b"NIGGABUTT", b"NiggaButt on SUI", b"The future of finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_q_Gg_A0uc_C_Po_D_Fatd_F6zz_Lug_8c0d5af8b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGABUTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGABUTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

