module 0x57cfb13b73efe5d9d7fd8fe958124d9f33a07e7cf0766a357442165e390a8e83::lokai {
    struct LOKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LOKAI>(arg0, 6, b"LOKAI", b"LOKAI by SuiAI", b"LOFAI is an AI-powered YETI where every holder adds a neuron to its brain! The more neurons it gains, the stronger and smarter its artificial intelligence becomes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/let0443_Create_a_blue_adult_Yeti_with_a_white_face_slim_and_a_3ab9a810_e06f_4547_b13b_1f3225cf094a_2_1_962231d6e6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOKAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOKAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

