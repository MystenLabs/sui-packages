module 0xe06b5dd5ea2b76ff479a5b8559ec33f05e080df1008c91372994b98ffe34972c::accompany {
    struct ACCOMPANY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACCOMPANY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACCOMPANY>(arg0, 6, b"Accompany", b"You don't have to go to the moon", b"Our SUI has its own loyal companions. You dont need to go to the moon; you just need to stay quiet and watch us closely. This is Evan Cheng's beloved dog, who will always be there to accompany and support everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gchs_D_Uj_Xs_AIY_8y_P_1_21802c599d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACCOMPANY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACCOMPANY>>(v1);
    }

    // decompiled from Move bytecode v6
}

